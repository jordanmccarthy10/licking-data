import matplotlib.pyplot as plt
from scipy.io import loadmat
import seaborn as sns

#this takes any array that is a row or a column of data you want to plot as points. this is a less intense version of swarmplot (just plots the distribution)

#change save name!!
save_file_name = "/Users/jordanmccarthy/Desktop/licking/ViolinLickingAmplitudes" #specify this every time

mat_data_presurgery = loadmat('/Users/jordanmccarthy/Desktop/licking/ControlBeforeAmplitudes.mat', squeeze_me=True) #specify this every time
mat_data_PCRt = loadmat('/Users/jordanmccarthy/Desktop/licking/PCRt_After_Amplitude.mat', squeeze_me=True) # specify this every time
mat_data_IRt = loadmat('/Users/jordanmccarthy/Desktop/licking/IRtAmplitudesAfter.mat', squeeze_me=True) # specify this every time

pre_data = mat_data_presurgery['BeforeAmplitudesBoth'] #make sure this matches the variable name in the first file
PCRt_data = mat_data_PCRt['AfterPeaks']
IRt_data = mat_data_IRt['AfterAmplitudes']

plt.figure(figsize=(10,6))

sns.violinplot(data=[pre_data, PCRt_data, IRt_data]) #there are additional parameters on the user guide that can change how the distribution is estimated
plt.xticks([0,1,2],['Before', 'PCRt', 'IRt']) #the category names
plt.ylabel('Lick Amplitude (AU)')
plt.title('Lick Amplitude Before and After Expression of TeLC')

plt.savefig(save_file_name+".pdf", dpi=1200)