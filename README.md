# licking-data
## check frame rate 
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 path/to/video.mp4
## change brightness of a video (without extracting frames)  
ffmpeg -i path/to/video.mp4 -vf "eq=brightness=0.4:contrast=1.6" output.mp4  
*may have to /Applications/ffmpeg*
## slow down a video (without extracting frames)  
ffmpeg -i input.mp4 -vf "setpts=2.0*PTS" output.mp4

## extract frames from a video
ffmpeg -i input_video.mp4 -vf "select='between(n,10,20)+between(n,40,50)+between(n,70,80)',setpts=N/FRAME_RATE/TB" output_frames_%03d.png
## put those frames back into a new video
ffmpeg -framerate 35 -i frame%03d.png -c:v libx264 -pix_fmt yuv420p output_video.mp4


## find drinking/sampling period information and analyze video
Open read_intan.m, change file_name to the digitalin.dat file of the session and change save_file_name. Run sections for drinking period and sampling period. Run the drinking/sampling period combined section - don't forget to change the save file name! Run extract_h5 in SampleandDrinkNumberofLicksPerBout, then open the SampleDrinkPeriods variable in that window. Run the rest of the sections in order. Manually save the areas, jaw_heights, sd_peaks, num_peaks, and InterLickIntervalInMilliseconds variables by right clicking and then "save as". Move to a python file to graph the variables.

## create raster plot of licking in a session
Use read_intan.m, run the first section using the intan digitalin.dat file and run the last session to save the needed variables as a mat file (make sure to change the save name at the bottom of the section). Then open LickingRaster.py, specify the name of the file you just saved and the save file name of the raster plot. Scroll down and manually specify the y=[] array with which trials had water dispensed (this is when SampleDrinkPeriods is NOT equal to 3501 - you can check in MATLAB). When this runs it will save the raster plot as a PDF wherever you specified. 

## workflow for analyzing optogenetics videos
Run the video through the Hourglas trained for this behavior using opto_jaw_config.json. Use read_intan.m to obtain the variable LaserStim. Run extract_h5 in opto_traces.m. Then takes heights and widths information to average_opto.m (or opto_plot/burst_opto_plot.py for a raw trace). From there, if plotting averages of one mouse use plotAVGopto.py. If plotting two or more mice averaged first use optocombined.m then use combinedplotAVGopto.py.
