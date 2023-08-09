import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns
import numpy as np

#this makes lineplots - it was used with areas data as an input to make a trace of the licking instead of just seeing the dots for the amplitude with swarmplot


#plot_title=''

save_file_name='/Users/jordanmccarthy/Desktop/RepTracesNew' #change!!

mat_Control_data=loadmat('/Users/jordanmccarthy/Desktop/licking/control_represent.mat')
mat_PCRt_data=loadmat('/Users/jordanmccarthy/Desktop/PCRt_third_rep.mat')
mat_IRt_data=loadmat('/Users/jordanmccarthy/Desktop/licking/Licking-data/IRt_data/IRt_represent_2.mat')

Control=np.squeeze(mat_Control_data['control_Represent']) #make sure these match the name of the variable contained in the file
PCRt=np.squeeze(mat_PCRt_data['PCRt_third_rep'])
IRt=np.squeeze(mat_IRt_data['IRt_represent_2'])

#makes three subplots, one for each trace
fig, axes=plt.subplots(1,3,figsize=(14,7))

sns.lineplot(x=np.arange(len(Control)), y=Control, color='blue', label='Control', ax=axes[0])
sns.lineplot(x=np.arange(len(PCRt)), y=PCRt, color='orange', label='PCRt Silencing', ax=axes[1])
sns.lineplot(x=np.arange(len(IRt)), y=IRt, color='red', label='IRt Silencing', ax=axes[2])

#set the x-lim and y-lim for each set of axes
axes[0].legend().set_visible(False)
axes[0].set_xlim(0,1000)
axes[0].set_ylim(0,17500)
axes[1].legend().set_visible(False)
axes[1].set_xlim(0,1000)
axes[1].set_ylim(0,17500)
axes[2].legend().set_visible(False)
axes[2].set_xlim(0,1000)
axes[2].set_ylim(0,17500)

#one legend for the whole graph
fig.legend(loc='upper right', ncol=1)
#fig.suptitle(plot_title, fontsize=14) use this if you want a title
plt.savefig(save_file_name+".pdf", dpi=1600)