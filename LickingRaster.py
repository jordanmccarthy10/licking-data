
import matplotlib.pyplot as plt
from scipy.io import loadmat
import numpy as np

#this takes input from the info for raster plot section of read_intan.m and requires manual input of which trials had water dispensed

#CHANGE TITLES and also check the drink period array at the bottom!!!!

raster_plot_title='Phox2B_#25 2023-0719' #change this as needed
save_file_name = ('/Users/jordanmccarthy/Desktop/licking_raster') #pick save name
mat_data_trials = loadmat('/Users/jordanmccarthy/Desktop/Phox2b#250719rasterplotinfo.mat') #tell it which file to load

Lick_timing = mat_data_trials['LickTimes']
Cue_timing = mat_data_trials['Cues']
Drink_timing = mat_data_trials['Water']
Water_dispense = np.squeeze(mat_data_trials['WaterDispense'])


plt.figure(figsize=(16,9)) #to make it big enough to see properly

#plots licks
for trials in range(len(Lick_timing)):
    plt.eventplot(Lick_timing[trials][0], lineoffsets=trials, linewidth=0.7)

#plots cues
plt.eventplot(Cue_timing, color='magenta', linelength=1)

#plots drinking periods as highlighted section - this works if mouse drank in every trial
#for y, drink_period in enumerate(Drink_timing):
    #plt.hlines(y, drink_period, drink_period+10, color='green', alpha=0.3, linewidth=1) 

#this puts the drinking period only where the mouse drank 
y=Water_dispense
i=0
for drink_period in Drink_timing:
  plt.hlines(y[i]-1, drink_period, drink_period+10, color='green', alpha=0.3, linewidth=1) 
  i += 1

plt.title(raster_plot_title) 
plt.ylabel('Trial')
plt.xlabel('Time (s)')
plt.ylim(0,len(Lick_timing+2))

plt.savefig(save_file_name+".pdf", dpi=1000)

