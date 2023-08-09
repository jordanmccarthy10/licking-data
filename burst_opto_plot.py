import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns
import numpy as np

#this one makes a lineplot of the whole session of bursting laser stimulation - no averages
#this needs the laserpulses from read_intan.m and then the heights and widths from opto_traces.m after extract_h5

plot_title='Phox2B#21 Burst Stimulation' #change
save_file_name='/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Jaw Movement Phox2B#21 Burst Stimulation' #change

mat_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Phox2B_#21_opto_burst_0.11mW_2023_0630_jawdata') #tell it which file - jaw
mat_laser_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/burst_laserpulses.mat') #tell it which file - laser


Heights=np.squeeze(mat_jaw_data['Heights'])
Widths=np.squeeze(mat_jaw_data['Widths'])
#Displacement=np.squeeze(mat_jaw_data['Jaw_displacement'])
LaserPulses=np.squeeze(mat_laser_data['LaserStim'])


plt.figure(figsize=(16,9)) #to make it big enough to see properly

sns.lineplot(x=np.arange(len(Heights)), y=Heights, color='blue', label='Vertical Position', linewidth=0.85)
sns.lineplot(x=np.arange(len(Widths)), y=Widths, color='green', label='Horizontal Position', linewidth=0.85)
#sns.lineplot(x=np.arange(len(Displacement)), y=Displacement, color='pink', label='Overall Position')

# to make the legend without making 27 entries
start_laser=LaserPulses[0]
end_laser=LaserPulses[0]+17.5
plt.axvspan(start_laser,end_laser, color='gray', alpha=0.3, label='Laser On')

for i in range(len(LaserPulses)):
    start_laser=LaserPulses[i]
    end_laser=LaserPulses[i]+17.5 #this is because each pulse should last 50ms
    plt.axvspan(start_laser,end_laser, color='gray', alpha=0.3)



sns.set_style('whitegrid')
plt.xlabel('Frames')
plt.ylabel('Jaw Position (AU)')
plt.title(plot_title)
plt.legend()

#plt.show()
plt.savefig(save_file_name+".pdf", dpi=1000)