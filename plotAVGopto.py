import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns
import numpy as np

#This takes average heights/widths and standard deviation data generated using matlab (average_opto.m for one mouse)
#and it generates a lineplot of the line plus of minus standard deviation for the continuous stimulation and 1s burst stimulation
#with the laser starts and stops marked

#there is a separate file called combinedplotAVGopto for more than on mouse since it's tedious to type out all of the variable names again

#go to bottom to specify save file name of the graph
plot_title='Phox2B #21 Average Jaw Positioning with ChRmine Stimulation' #change!
mat_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Phox2B_#21_avgoptodata') #file for the continuous stimulation heights/widths
mat_STD_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Phox2B_#21_avgSTDopto') #file for continuous stim standard deviations
mat_burst_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/burst_avgoptodata_#21') #burst stimulation heights/widths
mat_burst_STD_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/burst_avgSTDdata_#21') #burst stim standard deviations

ShortVert=np.squeeze(mat_jaw_data['short_avg_vert']) #this section extracts the matlab variables
ShortHorz=np.squeeze(mat_jaw_data['short_avg_horz'])
MedVert=np.squeeze(mat_jaw_data['med_avg_vert'])
MedHorz=np.squeeze(mat_jaw_data['med_avg_horz'])
LongVert=np.squeeze(mat_jaw_data['long_avg_vert'])
LongHorz=np.squeeze(mat_jaw_data['long_avg_horz'])
BurstVert=np.squeeze(mat_burst_jaw_data['burst_avg_vert'])
BurstHorz=np.squeeze(mat_burst_jaw_data['burst_avg_horz'])

SVertSTD=np.squeeze(mat_STD_data['short_vert_STDdevs']) #this section extracts the standard deviations
SHorzSTD=np.squeeze(mat_STD_data['short_horz_STDdevs'])
MVertSTD=np.squeeze(mat_STD_data['med_vert_STDdevs'])
MHorzSTD=np.squeeze(mat_STD_data['med_horz_STDdevs'])
LVertSTD=np.squeeze(mat_STD_data['long_vert_STDdevs'])
LHorzSTD=np.squeeze(mat_STD_data['long_horz_STDdevs'])
BurstHorzSTD=np.squeeze(mat_burst_STD_data['burst_horz_STDdevs'])
BurstVertSTD=np.squeeze(mat_burst_STD_data['burst_vert_STDdevs'])

UpperSTDShortVert=np.zeros(len(SVertSTD)) #this section creates new arrays with the mean+/- the standard dev
LowerSTDShortVert=np.zeros(len(SVertSTD))
UpperSTDShortHorz=np.zeros(len(SVertSTD))
LowerSTDShortHorz=np.zeros(len(SVertSTD))
for frames in range(len(ShortVert)):
    UpperSTDShortVert[frames]=ShortVert[frames]+SVertSTD[frames]
    LowerSTDShortVert[frames]=ShortVert[frames]-SVertSTD[frames]
    UpperSTDShortHorz[frames]=ShortHorz[frames]+SHorzSTD[frames]
    LowerSTDShortHorz[frames]=ShortHorz[frames]-SHorzSTD[frames]

UpperSTDMedVert=np.zeros(len(MVertSTD))
LowerSTDMedVert=np.zeros(len(MVertSTD))
UpperSTDMedHorz=np.zeros(len(MVertSTD))
LowerSTDMedHorz=np.zeros(len(MVertSTD))
for frames in range(len(MedVert)):
    UpperSTDMedVert[frames]=MedVert[frames]+MVertSTD[frames]
    LowerSTDMedVert[frames]=MedVert[frames]-MVertSTD[frames]
    UpperSTDMedHorz[frames]=MedHorz[frames]+MHorzSTD[frames]
    LowerSTDMedHorz[frames]=MedHorz[frames]-MHorzSTD[frames]

UpperSTDLongVert=np.zeros(len(LVertSTD))
LowerSTDLongVert=np.zeros(len(LVertSTD))
UpperSTDLongHorz=np.zeros(len(LVertSTD))
LowerSTDLongHorz=np.zeros(len(LVertSTD))
for frames in range(len(LongVert)):
    UpperSTDLongVert[frames]=LongVert[frames]+LVertSTD[frames]
    LowerSTDLongVert[frames]=LongVert[frames]-LVertSTD[frames]
    UpperSTDLongHorz[frames]=LongHorz[frames]+LHorzSTD[frames]
    LowerSTDLongHorz[frames]=LongHorz[frames]-LHorzSTD[frames]

UpperSTDBurstVert=np.zeros(len(BurstVertSTD))
LowerSTDBurstVert=np.zeros(len(BurstVertSTD))
UpperSTDBurstHorz=np.zeros(len(BurstHorzSTD))
LowerSTDBurstHorz=np.zeros(len(BurstHorzSTD))
for frames in range(len(BurstVert)):
    UpperSTDBurstVert[frames]=BurstVert[frames]+BurstVertSTD[frames]
    LowerSTDBurstVert[frames]=BurstVert[frames]-BurstVertSTD[frames]
    UpperSTDBurstHorz[frames]=BurstHorz[frames]+BurstHorzSTD[frames]
    LowerSTDBurstHorz[frames]=BurstHorz[frames]-BurstHorzSTD[frames]


#this section plots all three trial timepoints side by side on a figure with 3 differenct axes - if you make a change to one you have to do it to every section

fig, axes=plt.subplots(1,4,figsize=(16,9))

sns.lineplot(x=np.arange(len(ShortVert)), y=ShortVert, color='blue', label='Vertical Position',ax=axes[0]) #vertical stimulation is blue
sns.lineplot(x=np.arange(len(ShortHorz)), y=ShortHorz, color='green', label='Horizontal Position',ax=axes[0]) #horizontal is green
sns.lineplot(x=np.arange(len(UpperSTDShortVert)),y=UpperSTDShortVert, color='blue', alpha=0, ax=axes[0])
sns.lineplot(x=np.arange(len(LowerSTDShortVert)),y=LowerSTDShortVert, color='blue', alpha=0, ax=axes[0])
sns.lineplot(x=np.arange(len(UpperSTDShortHorz)),y=UpperSTDShortHorz, color='green', alpha=0, ax=axes[0])
sns.lineplot(x=np.arange(len(LowerSTDShortHorz)),y=LowerSTDShortHorz, color='green', alpha=0, ax=axes[0])
axes[0].fill_between(x=np.arange(len(UpperSTDShortVert)),y1=LowerSTDShortVert, y2=UpperSTDShortVert, color='blue', alpha=0.2, edgecolor='None')
axes[0].fill_between(x=np.arange(len(UpperSTDShortHorz)),y1=LowerSTDShortHorz, y2=UpperSTDShortHorz, color='green', alpha=0.2, edgecolor='None')
axes[0].axvspan(0,35, color='gray', alpha=0.3, label='Laser On') #the laser is gray, the duration is manually defined with math based on how long it should be
axes[0].set_title('100ms stimulation')

sns.lineplot(x=np.arange(len(MedVert)), y=MedVert, color='blue', ax=axes[1])
sns.lineplot(x=np.arange(len(MedHorz)), y=MedHorz, color='green', ax=axes[1])
sns.lineplot(x=np.arange(len(UpperSTDMedVert)),y=UpperSTDMedVert, color='blue', alpha=0, ax=axes[1])
sns.lineplot(x=np.arange(len(LowerSTDMedVert)),y=LowerSTDMedVert, color='blue', alpha=0, ax=axes[1])
sns.lineplot(x=np.arange(len(UpperSTDMedHorz)),y=UpperSTDMedHorz, color='green', alpha=0, ax=axes[1])
sns.lineplot(x=np.arange(len(LowerSTDMedHorz)),y=LowerSTDMedHorz, color='green', alpha=0, ax=axes[1])
axes[1].fill_between(x=np.arange(len(UpperSTDMedVert)),y1=LowerSTDMedVert, y2=UpperSTDMedVert, color='blue', alpha=0.2, edgecolor='None')
axes[1].fill_between(x=np.arange(len(UpperSTDMedHorz)),y1=LowerSTDMedHorz, y2=UpperSTDMedHorz, color='green', alpha=0.2, edgecolor='None')
axes[1].axvspan(0,175, color='gray', alpha=0.3)
axes[1].set_title('500ms stimulation')

sns.lineplot(x=np.arange(len(LongVert)), y=LongVert, color='blue', ax=axes[2])
sns.lineplot(x=np.arange(len(LongHorz)), y=LongHorz, color='green', ax=axes[2])
sns.lineplot(x=np.arange(len(UpperSTDLongVert)),y=UpperSTDLongVert, color='blue', alpha=0, ax=axes[2])
sns.lineplot(x=np.arange(len(LowerSTDLongVert)),y=LowerSTDLongVert, color='blue', alpha=0, ax=axes[2])
sns.lineplot(x=np.arange(len(UpperSTDLongHorz)),y=UpperSTDLongHorz, color='green', alpha=0, ax=axes[2])
sns.lineplot(x=np.arange(len(LowerSTDLongHorz)),y=LowerSTDLongHorz, color='green', alpha=0, ax=axes[2])
axes[2].fill_between(x=np.arange(len(UpperSTDLongVert)),y1=LowerSTDLongVert, y2=UpperSTDLongVert, color='blue', alpha=0.2, edgecolor='None')
axes[2].fill_between(x=np.arange(len(UpperSTDLongHorz)),y1=LowerSTDLongHorz, y2=UpperSTDLongHorz, color='green', alpha=0.2, edgecolor='None')
axes[2].axvspan(0,350, color='gray', alpha=0.3)
axes[2].set_title('1000ms stimulation')

sns.lineplot(x=np.arange(len(BurstVert)), y=BurstVert, color='blue', ax=axes[3])
sns.lineplot(x=np.arange(len(BurstHorz)), y=BurstHorz, color='green', ax=axes[3])
sns.lineplot(x=np.arange(len(UpperSTDBurstVert)),y=UpperSTDBurstVert, color='blue', alpha=0, ax=axes[3])
sns.lineplot(x=np.arange(len(LowerSTDBurstVert)),y=LowerSTDBurstVert, color='blue', alpha=0, ax=axes[3])
sns.lineplot(x=np.arange(len(UpperSTDBurstHorz)),y=UpperSTDBurstHorz, color='green', alpha=0, ax=axes[3])
sns.lineplot(x=np.arange(len(LowerSTDBurstHorz)),y=LowerSTDBurstHorz, color='green', alpha=0, ax=axes[3])
axes[3].fill_between(x=np.arange(len(UpperSTDBurstVert)),y1=LowerSTDBurstVert, y2=UpperSTDBurstVert, color='blue', alpha=0.2, edgecolor='None')
axes[3].fill_between(x=np.arange(len(UpperSTDBurstHorz)),y1=LowerSTDBurstHorz, y2=UpperSTDBurstHorz, color='green', alpha=0.2, edgecolor='None')
for bursting in range(0,11):
    start_burst=0+35*bursting
    end_burst=17.5+35*bursting
    axes[3].axvspan(start_burst,end_burst, color='gray', alpha=0.3)
axes[3].set_title('1000ms burst stimulation (10Hz)')

#turns off individual legends
axes[0].legend().set_visible(False)
axes[1].legend().set_visible(False)
axes[2].legend().set_visible(False)
axes[3].legend().set_visible(False)

fig.legend(loc='upper right', ncol=1) #makes only one legend for the whole graph
fig.suptitle(plot_title, fontsize=14) #define the plot title above
fig.text(.5, 0.06, 'Frames', ha='center', va='center', fontsize=14) #x-axis label
fig.text(0.06,.5,'Jaw Position (AU)', ha='center', va='center', rotation='vertical', fontsize=14) #y-axis label
plt.tight_layout #brings the plots closer together
#plt.show()

plt.savefig('/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/Phox2B#21AVGposition'+".pdf", dpi=1000) 
#the first one is the save name