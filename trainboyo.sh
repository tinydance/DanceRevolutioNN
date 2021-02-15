#!/bin/bash
#
#SBATCH --job-name=DANCE_REVOLUTION
#SBATCH --output=/zooper2/tinydancer/DanceRevolution/pretraining_test_log.txt
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --gres-flags=enforce-binding
#SBATCH --nodes=1-1
#SBATCH --mem=2gb

#This is a sample SLURM job script
#It has a job name called JOB_NAME
#It will save it's stdout to /zooper1/USERNAME/output.txt
#It will have access to 2 GPUs and 1GB of RAM for a maximum of 1 minute
#The minimum allocatable time is 1 minute

echo "CUDA DEVICES: $CUDA_VISIBLE_DEVICES"

# export CUDA_VISIBLE_DEVICES=3

#  model_dir=checkpoints_windowsize100_hidden1024_fixedsteps10_alpha0.01

export CUDA_HOME="/usr/local/cuda-10.0"
export PATH="$PATH:/usr/local/cuda-10.0/bin"
export LD_LIBRARY_PATH="/usr/local/cuda-10.0/lib64"
export PATH="$PATH:/usr/local/bin/conda"

/zooper2/tinydancer/DanceRevolution/bin/python train.py --train_dir /zooper2/tinydancer/DanceRevolution/data/train_1min_2 \
                --valid_dir /zooper2/tinydancer/DanceRevolution/data/valid_1min_2 \
                --output_dir /zooper2/tinydancer/DanceRevolution/output \
                --batch_size 32 \
                --lr 0.0001 \
                --dropout 0.05 \
                --frame_dim 438 \
                --encoder_hidden_size 1024 \
                --pose_dim 50 \
                --decoder_hidden_size 512 \
                --seq_len 300 \
                --max_seq_len 4500 \
                --num_heads 8 \
                --num_layers 3 \
                --window_size 100 \
                --fixed_step 10 \
                --alpha 0.01 \
                --save_per_epochs 1
		--pretrained_path /zooper2/tinydancer/DanceRevolution/trained_models/ballet_only/epoch_9990.pt
		--epochs 1

