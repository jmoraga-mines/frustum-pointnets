#!/bin/bash

KITTI_DEFAULT=dataset/KITTI/object/training/label_2/
KITTI_BASE=/store01/shared/kitti/training/label_2/
KITTI_WENDIAN=/scratch/sets/subt/kitti/training/label_2/
KITTI_LABEL_DIR=

if [-d $KITTI_BASE]; then
	KITTI_LABEL_DIR=$KITTI_BASE
else if [-d $KITTI_WENDIAN]; then
	KITTI_LABEL_DIR=$KITTI_WENDIAN
else if [-d $KITTI_DEFAULT]; then
	KITTI_LABEL_DIR=$KITTI_DEFAULT
else
	echo "No KITTI data source found"
	exit (-1)
fi

python train/test.py --gpu 0 --num_point 1024 --model frustum_pointnets_v1 --model_path train/log_v1/model.ckpt --output train/detection_results_v1 --data_path kitti/frustum_carpedcyc_val_rgb_detection.pickle --from_rgb_detection --idx_path kitti/image_sets/val.txt --from_rgb_detection

if [-d $KITTI_BASE]; then
	train/kitti_eval/evaluate_object_3d_offline $KITTI_BASE train/detection_results_v1
else if [-d $KITTI_WENDIAN]; then
	train/kitti_eval/evaluate_object_3d_offline $KITTI_WENDIAN train/detection_results_v1
else if [-d $KITTI_DEFAULT]; then
        train/kitti_eval/evaluate_object_3d_offline $KITTI_DEFAULT train/detection_results_v1
else
	echo "No KITTI data source found"
fi

### Original was:
# train/kitti_eval/evaluate_object_3d_offline dataset/KITTI/object/training/label_2/ train/detection_results_v1
