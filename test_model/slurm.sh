#!/bin/bash
#
#SBATCH --job-name=DANCE_REVOLUTION
#SBATCH --output=/zooper2/tinydancer/DanceRevolution/test_model/log.log
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

export CUDA_HOME="/usr/local/cuda-10.0"
export PATH="$PATH:/usr/local/cuda-10.0/bin"
export LD_LIBRARY_PATH="/usr/local/cuda-10.0/lib64"
export PATH="$PATH:/usr/local/bin/conda"

image_dir="test_output/outputs.test.images"
json_dir="test_output/outputs.test.json"
input_dir="test_audio"
output_dir="test_output"
	
/zooper2/tinydancer/DanceRevolution/bin/python test2.py --input_dir ${input_dir} \
	--model epoch_9990.pt \
	--json_dir ${json_dir} \
	--image_dir ${image_dir} \
	--batch_size 1

dances=$(ls ${image_dir})
for dance in ${dances}:
do
	ffmpeg -r 15 -i ${image_dir}/${dance}/frame%06d.jpg -vb 20M -vcodec mpeg4 -y ${output_dir}/${dance}.mp4
	echo "Created ${output_dir}/${dance}.mp4"
done

