import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns
import numpy as np

#this makes one long trace of the whole optogenetics laser stimulation session - no averages, a raw trace to view the whole session
#it needs the laser pulses from read_intan.m and the jaw widths and heights from the extract_h5 function in opto_traces.m

plot_title='Phox2B#21 Continuous Stimulation' #change
save_file_name='/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Jaw Movement Phox2B#21 Continuous Stimulation' #change

mat_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Phox2B_#21_opto_contin_0.11mW_2023_0630_jawdata') #tell it which file - jaw data
mat_laser_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/contin_laserpulses.mat') #tell it which file - laser


Heights=np.squeeze(mat_jaw_data['Heights'])
Widths=np.squeeze(mat_jaw_data['Widths'])
#Displacement=np.squeeze(mat_jaw_data['Jaw_displacement'])
LaserPulses=np.squeeze(mat_laser_data['LaserStim'])


plt.figure(figsize=(16,9)) #to make it big enough to see properly

sns.lineplot(x=np.arange(len(Heights)), y=Heights, color='blue', label='Vertical Position', linewidth=0.9)
sns.lineplot(x=np.arange(len(Widths)), y=Widths, color='green', label='Horizontal Position', linewidth=0.9)
#sns.lineplot(x=np.arange(len(Displacement)), y=Displacement, color='pink', label='Overall Position')

# to make the legend without making 27 entries
start_laser=LaserPulses[0]
end_laser=LaserPulses[0]+35
plt.axvspan(start_laser,end_laser, color='gray', alpha=0.3, label='Laser On')

for i in range(1,9):
    start_laser=LaserPulses[i]
    end_laser=LaserPulses[i]+35 #the duration is manually set by doing math for how long the laser is
    plt.axvspan(start_laser,end_laser, color='gray', alpha=0.3)

for i in range(9,18):
    start_laser=LaserPulses[i]
    end_laser=LaserPulses[i]+175
    plt.axvspan(start_laser,end_laser, color='gray', alpha=0.3)

for i in range(18,27):
   start_laser=LaserPulses[i]
   end_laser=LaserPulses[i]+350
   plt.axvspan(start_laser,end_laser, color='gray', alpha=0.3)

sns.set_style('whitegrid')

plt.xlabel('Frames')
plt.ylabel('Jaw Position (AU)')
plt.title(plot_title)
plt.legend()
#plt.show()
plt.savefig(save_file_name+".pdf", dpi=1000)