import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns
import numpy as np

plot_title='Phox2B#20 Continuous Stimulation' #change
save_file_name='/Users/jordanmccarthy/Desktop/licking/opto/Jaw Movement Phox2B#20 Continuous Stimulation' #change
mat_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B_#20_opto_contin_0.11mW_2023_0630_jawdata') #tell it which file - jaw
mat_laser_data=loadmat('/Users/jordanmccarthy/Desktop/licking/laserstim.mat') #tell it which file - laser


Heights=np.squeeze(mat_jaw_data['Heights'])
Widths=np.squeeze(mat_jaw_data['Widths'])
Displacement=np.squeeze(mat_jaw_data['Jaw_displacement'])
LaserPulses=np.squeeze(mat_laser_data['LaserStim'])


plt.figure(figsize=(16,9)) #to make it big enough to see properly

sns.lineplot(x=np.arange(len(Heights)), y=Heights, color='blue', label='Vertical Position')
sns.lineplot(x=np.arange(len(Widths)), y=Widths, color='green', label='Horizontal Position')
#sns.lineplot(x=np.arange(len(Displacement)), y=Displacement, color='pink', label='Overall Position')

# to make the legend without making 27 entries
start_laser=LaserPulses[0]
end_laser=LaserPulses[0]+35
plt.axvspan(start_laser,end_laser, color='orange', alpha=0.3, label='Laser On')

for i in range(1,9):
    start_laser=LaserPulses[i]
    end_laser=LaserPulses[i]+35
    plt.axvspan(start_laser,end_laser, color='orange', alpha=0.3)

for i in range(9,18):
    start_laser=LaserPulses[i]
    end_laser=LaserPulses[i]+175
    plt.axvspan(start_laser,end_laser, color='orange', alpha=0.3)

for i in range(18,27):
   start_laser=LaserPulses[i]
   end_laser=LaserPulses[i]+350
   plt.axvspan(start_laser,end_laser, color='orange', alpha=0.3)

sns.set_style('whitegrid')
plt.xlabel('Frames')
plt.ylabel('Jaw Position (AU)')
plt.title(plot_title)
plt.legend()
plt.show()
#plt.savefig(save_file_name+".pdf", dpi=1000)