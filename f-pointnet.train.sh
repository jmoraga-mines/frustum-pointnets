#!/bin/bash
#SBATCH --time=144:00:00
#SBATCH --partition=gpu
#SBATCH --overcommit
#SBATCH --exclusive
##SBATCH --nodelist=g001,g002,g003,g004,g005
#SBATCH --gres=gpu:4
##SBATCH --ntasks=1
#SBATCH --export=ALL
#SBATCH --out=wendian-gpu/%J.out
#SBATCH --err=wendian-gpu/%J.msg
#SBATCH --mem=32G
#SBATCH --nodes=1

# Go to the directoy from which our job was launched
cd $SLURM_SUBMIT_DIR
echo "slurm directory " $SLURM_SUBMIT_DIR
cat $0 > wendian-gpu/$SLURM_JOB_ID.script
srun hostname | sort -u > wendian-gpu/$SLURM_JOB_ID.hosts

#set up our environment
source /etc/profile
module purge

#set up our environment
module add libs/cuda/10.1
conda activate pointclouds
export LD_LIBRARY_PATH=/sw/libs/cuda/10.1/extras/CUPTI/lib64:/sw/libs/cuda/10.1/lib64:/scratch/jmoraga/cuda-10/lib64

ulimit -c 0
#this may help run better
ulimit -u 4096



# Single Node to compile
# srun -N 1 -p gpu -t 1:00:00 --mem 32G --pty bash 

srun -N 1 -p gpu -t 144:00:00 --mem 32G --exclusive sh scripts/command_train_v1.sh

# srun -N 1 -p gpu -t 1:00:00 --mem 32G ./darknet detector train cfg/edgar.data cfg/edgar.cfg darknet53.conv.74 -gpus 0
# srun -N 1 -p gpu -t 1:30:00 --mem 32G ./darknet detector train cfg/edgar.data cfg/edgar.cfg darknet53.conv.74 -gpus 0 -dont_show -map
# srun -N 1 -p gpu -t 1:30:00 --mem 32G ./darknet detector train cfg/edgar.data cfg/edgar.cfg backup/edgar_last.weights -gpus 0 -dont_show -map
