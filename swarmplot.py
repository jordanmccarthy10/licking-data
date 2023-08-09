import seaborn as sns
from scipy.io import loadmat
import matplotlib.pyplot as plt

#this code was used for many swarmplots by adjusting the number of plots. it takes any arrays of things you want to plot as points.
#if you have many points it will take a long time to code (use violinplot.py for a less intensive plot)

#change save name!!
save_file_name = "/Users/jordanmccarthy/Desktop/licking/LickingAmplitudes" #specify this every time

# extract the peaks data from the MATLAB files
mat_data_presurgery = loadmat('/Users/jordanmccarthy/Desktop/licking/ControlBeforeAmplitudes.mat', squeeze_me=True) #specify this every time
mat_data_PCRt = loadmat('/Users/jordanmccarthy/Desktop/licking/PCRt_After_Amplitude.mat', squeeze_me=True) # specify this every time
mat_data_IRt = loadmat('/Users/jordanmccarthy/Desktop/licking/IRtAmplitudesAfter.mat', squeeze_me=True) # specify this every time

pre_data = mat_data_presurgery['BeforeAmplitudesBoth'] #make sure this matches the variable in the first file, etc.
PCRt_data = mat_data_PCRt['AfterPeaks']
IRt_data = mat_data_IRt['AfterAmplitudes']


plt.figure(figsize=(10,5))

#create swarmplot
sns.swarmplot(x=['Control']*len(pre_data), y=pre_data, color='blue', size=0.8) #size is dot size, needs to be small for lots of dots or they don't plot
sns.swarmplot(x=['PCRt Silencing']*len(PCRt_data), y=PCRt_data, color='orange', size=0.8)
sns.swarmplot(x=['IRt Silencing']*len(IRt_data), y=IRt_data, color='red', size=0.8)

plt.ylabel('Amplitude')
#plt.title('Licking Amplitude')
#plt.show()
#save the plot as a PDF
plt.savefig(save_file_name+".pdf",dpi=1000)

#if plot.show() is on it will not save
