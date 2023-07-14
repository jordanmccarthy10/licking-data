import seaborn as sns
from scipy.io import loadmat
import matplotlib.pyplot as plt


save_file_name = "/Users/jordanmccarthy/Desktop/amplitudes_Phox2B#26" #specify this every time

# extract the peaks data from the MATLAB files
mat_data_sampling = loadmat('/Users/jordanmccarthy/Desktop/licking/Phox2B_#26/20230707/samplingpeaks#26_07072023.mat', squeeze_me=True) #specify this every time
mat_data_drinking = loadmat('/Users/jordanmccarthy/Desktop/licking/Phox2B_#26/20230707/drinkingpeaks#26_07072023.mat', squeeze_me=True) # specify this every time
sampling_data = mat_data_sampling['sampling_peaks'] 
drinking_data = mat_data_drinking['drinking_peaks']

#create swarmplot
sns.swarmplot(x=['Sampling Period']*len(sampling_data), y=sampling_data, color='blue', size=1.5)
sns.swarmplot(x=['Drinking Period']*len(drinking_data), y=drinking_data, color='orange', size=1.5)

plt.ylabel('Amplitude')
plt.title('Licking Amplitude in Sampling Versus Drinking Period')

#save the plot as a PDF
plt.savefig(save_file_name,dpi=1000)
