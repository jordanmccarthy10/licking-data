# licking-data
## check frame rate 
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 path/to/video.mp4
## change brightness of a video (without extracting frames)  
ffmpeg -i path/to/video.mp4 -vf "eq=brightness=1.5" output.mp4 *greater than one is brighter, 1.5 is too bright*
