#!/bin/bash

#######################
## Default variables ##
#######################
input_dir="/zooper2/tinydancer/DanceRevolution/test_model/raw_audio/"
work_dir="/zooper2/tinydancer/DanceRevolution/"
duration="60"
fps="15"

##########################
## Preprocessing Script ##
##########################

#make dirs if they don't exist
mkdir -p test_audio
mkdir -p test_output
test_audio="${work_dir}/test_model/test_audio"
test_output="${work_dir}/test_model/test_output"


# Go to work dir
# cd ${work_dir}


# Iterate over the videos in the input directory 
for audio in ${input_dir}*.m4a
do
	# Print progress
	echo "Processing ${audio}..."

	# Edit the video:
	#   *Don't overwrite mod files that exist
	#   *show warnings
	#   *force fps to  $fps
	#   *set video duration to $duration seconds
	#   *output into a filename_mod.mp4 file 
	filename="${audio##*/}"
	edited_audio="${test_audio}/${filename%.*}.m4a"
	echo "$edited_audio"
	ffmpeg 	-n\
		-loglevel 24\
		-i "${audio}"\
		-r "${fps}"\
 		-t "${duration}"\
		"${edited_audio}"
done

###############
## Run Model ##
###############

exit
