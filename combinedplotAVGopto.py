import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns
import numpy as np

#this takes the output from optocombined.m and plots jaw position lineplots for multiple mice averaged together for the continuous laser stimulation and the burst 1s stimulation. 
#to plot values from one mouse (used average_opto.m only) use plotAVGopto.py


#go to bottom to specify save file name of the graph
plot_title='Average Jaw Positioning with ChRmine Stimulation' #change!
mat_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDavgvalues') #the continuous average values for heights/widths
mat_STD_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDstd') #continuous standard deviations
mat_burst_jaw_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDBURSTavgvalues') #burst avg values
mat_burst_STD_data=loadmat('/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDBURSTstd') #burst standard deviations

ShortVert=np.squeeze(mat_jaw_data['avg_all_svf']) #this section extracts the matlab variables
ShortHorz=np.squeeze(mat_jaw_data['avg_all_shf'])
MedVert=np.squeeze(mat_jaw_data['avg_all_mvf'])
MedHorz=np.squeeze(mat_jaw_data['avg_all_mhf'])
LongVert=np.squeeze(mat_jaw_data['avg_all_lvf'])
LongHorz=np.squeeze(mat_jaw_data['avg_all_lhf'])
BurstVert=np.squeeze(mat_burst_jaw_data['avg_all_bvf'])
BurstHorz=np.squeeze(mat_burst_jaw_data['avg_all_bhf'])

SVertSTD=np.squeeze(mat_STD_data['std_all_svf']) #this section extracts the standard deviations
SHorzSTD=np.squeeze(mat_STD_data['std_all_shf'])
MVertSTD=np.squeeze(mat_STD_data['std_all_mvf'])
MHorzSTD=np.squeeze(mat_STD_data['std_all_mhf'])
LVertSTD=np.squeeze(mat_STD_data['std_all_lvf'])
LHorzSTD=np.squeeze(mat_STD_data['std_all_lhf'])
BurstHorzSTD=np.squeeze(mat_burst_STD_data['std_all_bhf'])
BurstVertSTD=np.squeeze(mat_burst_STD_data['std_all_bvf'])

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


#this section plots all three trial timepoints side by side on a figure with 3 differenct axes

fig, axes=plt.subplots(1,4,figsize=(16,9))

sns.lineplot(x=np.arange(len(ShortVert)), y=ShortVert, color='blue', label='Vertical Position',ax=axes[0])
sns.lineplot(x=np.arange(len(ShortHorz)), y=ShortHorz, color='green', label='Horizontal Position',ax=axes[0])
sns.lineplot(x=np.arange(len(UpperSTDShortVert)),y=UpperSTDShortVert, color='blue', alpha=0, ax=axes[0])
sns.lineplot(x=np.arange(len(LowerSTDShortVert)),y=LowerSTDShortVert, color='blue', alpha=0, ax=axes[0])
sns.lineplot(x=np.arange(len(UpperSTDShortHorz)),y=UpperSTDShortHorz, color='green', alpha=0, ax=axes[0])
sns.lineplot(x=np.arange(len(LowerSTDShortHorz)),y=LowerSTDShortHorz, color='green', alpha=0, ax=axes[0])
axes[0].fill_between(x=np.arange(len(UpperSTDShortVert)),y1=LowerSTDShortVert, y2=UpperSTDShortVert, color='blue', alpha=0.2, edgecolor='None')
axes[0].fill_between(x=np.arange(len(UpperSTDShortHorz)),y1=LowerSTDShortHorz, y2=UpperSTDShortHorz, color='green', alpha=0.2, edgecolor='None')
axes[0].axvspan(0,35, color='gray', alpha=0.3, label='Laser On') #laser is gray, duration is manually defined with the math for how long it should be in frames
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


#turns off the legends for each graph
axes[0].legend().set_visible(False)
axes[1].legend().set_visible(False)
axes[2].legend().set_visible(False)
axes[3].legend().set_visible(False)


fig.legend(loc='upper right', ncol=1) #makes one legend for the whole graph
fig.suptitle(plot_title, fontsize=14)
fig.text(.5, 0.06, 'Frames', ha='center', va='center', fontsize=14) #x-axis
fig.text(0.06,.5,'Jaw Position (AU)', ha='center', va='center', rotation='vertical', fontsize=14) #y-axis
plt.tight_layout #brings axes closer to each other
#plt.show()

plt.savefig('/Users/jordanmccarthy/Desktop/licking/opto/combinedAVGposition'+".pdf", dpi=1000)
#change the save name!!!