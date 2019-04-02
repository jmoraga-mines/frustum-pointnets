#!/bin/bash

source ~/.bashrc
#source /u/mx/fo/jmoraga/anaconda2/etc/profile.d/conda.sh
#export PATH=//u/mx/fo/jmoraga/anaconda2/bin:$PATH
conda activate pointnets && \
python train/train.py --gpu 0 --model frustum_pointnets_v1 --log_dir train/log_v1 --num_point 1024 --max_epoch 201 --batch_size 32 --decay_step 800000 --decay_rate 0.5
