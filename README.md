# licking-data
## check frame rate 
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 path/to/video.mp4
## change brightness of a video (without extracting frames)  
ffmpeg -i path/to/video.mp4 -vf "eq=brightness=0.4:contrast=1.6" output.mp4  
*may have to /Applications/ffmpeg*
## slow down a video (without extracting frames)  
ffmpeg -i input.mp4 -vf "setpts=2.0*PTS" output.mp4


## find drinking period information to analyze video
Open read_intan.m, change file_name and save_file_name, and run both sections. Right click on the drinkingPeriods cell array, save as, and save it. Drag it into NumberOfLicksPerBout.m to open it as a variable there. Run extract_h5 and plot traces for inspection, then the section "plot only peaks from the drinking period
