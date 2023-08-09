import seaborn as sns
from scipy.io import loadmat
import matplotlib.pyplot as plt
import numpy as np

#This makes histograms based on percent in total data, with the option to cap data

#InterLick_interval_InMillisecond
#num_peaks
#agg_freq

#change save name!!!
save_file_name='/Users/jordanmccarthy/Desktop/licking/ILI_histogramOverlap'

mat_data_presurgery=loadmat('/Users/jordanmccarthy/Desktop/licking/ControlBeforeIRt.mat')
mat_data_PCRt=loadmat('/Users/jordanmccarthy/Desktop/licking/PCRt_After_ILI.mat')
mat_data_IRt=loadmat('/Users/jordanmccarthy/Desktop/licking/IRtAfterILI.mat')

pre_data=np.squeeze(mat_data_presurgery['BeforeILIBoth'])
PCRt_data=np.squeeze(mat_data_PCRt['AfterILI'])
IRt_data=np.squeeze(mat_data_IRt['AfterILI'])

## data is capped so every value over cap is in the last peak - need to change x-axis in illustrator
capped_pre_data = np.minimum(pre_data, 500) #this is the capping number
capped_PCRt_data=np.minimum(PCRt_data, 500)
capped_IRt_data=np.minimum(IRt_data, 500)


plt.figure(figsize=(14,9)) #dont forget to change bin size!!!
sns.histplot(capped_pre_data, binwidth=10, kde=False, color='blue', stat='percent', label='Control')
sns.histplot(capped_PCRt_data, binwidth=10,kde=False, color='orange', stat='percent', label='PCRt Silencing', alpha=0.5)
sns.histplot(capped_IRt_data, binwidth=10,kde=False, color='red', stat='percent', label='IRt Silencing', alpha=0.5)

plt.title('Inter-lick Interval Before and After Expression of TeLC')
plt.ylim(0,25)
plt.xticks([50,100,150,200,250,300,350,400,450,500])
plt.legend()

#this block if you wanted to define aspects of the graphs differently for some reason
#axes[0].set_title('Control')
#axes[1].set_title('PCRt Silencing')
#axes[2].set_title('IRt Silencing')
#axes[0].set_ylim(0,25)
#axes[1].set_ylim(0,25)
#axes[2].set_ylim(0,25)
#axes[0].set_xticks([50,100,150,200,250,300,350,400,450,500])
#axes[1].set_xticks([50,100,150,200,250,300,350,400,450,500])
#axes[2].set_xticks([50,100,150,200,250,300,350,400,450,500])

#plt.show()
plt.savefig(save_file_name+".pdf", dpi=1000)
