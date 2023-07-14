# licking-data
## check frame rate 
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 path/to/video.mp4
## change brightness of a video (without extracting frames)  
ffmpeg -i path/to/video.mp4 -vf "eq=brightness=0.4:contrast=1.6" output.mp4  
*may have to /Applications/ffmpeg*
## slow down a video (without extracting frames)  
ffmpeg -i input.mp4 -vf "setpts=2.0*PTS" output.mp4


## find drinking period and sampling period information to analyze video
Open read_intan.m, change file_name to the digitalin.dat file of the session and change save_file_name. Run sections for drinking period and sampling period. Right click on the drinkingPeriods and samplingPeriods cell arrays, save as. Drag it into NumberOfLicksPerBout.m to open it as a variable there. Run extract_h5 and plot traces for inspection, then the section "plot only peaks from the drinking period" and "plot peaks from drinking and sampling period". 

## create raster plot of licking in a session
Use read_intan.m, run the first section using the intan digitalin.dat file and run the last session to save the needed variables as a mat file (make sure to change the save name at the bottom of the section). Then open LickingRaster.py, specify the name of the file you just saved and the save file name of the raster plot. When this runs it will save the raster plot as a PDF wherever you specified. 

## swarmplot.py makes a swarmplot of peaks data from the sampling and drinking periods (currently requires those two variables to be saved in different files). Can be adjusted to require one file and also to plot amplitudes of any peaks data
