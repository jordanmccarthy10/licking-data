# licking-data
## check frame rate 
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 path/to/video.mp4
