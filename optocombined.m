%combining the data - this will concatenate the data from two mice together
%by trial type


all_bhf=cell(length(burst_horz_frames),1);
for frame = 1:length(burst_horz_frames)
    all_bhf{frame} = [burst_horz_frames{frame},burst_horz_frames20{frame}]; %this is where you change to concatenate two arrays
end

all_bvf=cell(length(burst_vert_frames),1);
for frame = 1:length(burst_vert_frames)
    all_bvf{frame} = [burst_vert_frames{frame},burst_vert_frames20{frame}];%this is where you change to concatenate two arrays
end

all_lvf=cell(length(long_vert_frames),1);
for frame = 1:length(long_vert_frames)
    all_lvf{frame} = [long_vert_frames{frame},long_vert_frames20{frame}];%this is where you change to concatenate two arrays
end

all_lhf=cell(length(long_horz_frames),1);
for frame = 1:length(long_horz_frames)
    all_lhf{frame} = [long_horz_frames{frame},long_horz_frames20{frame}];%this is where you change to concatenate two arrays
end

all_mvf=cell(length(med_vert_frames),1);
for frame = 1:length(med_vert_frames)
    all_mvf{frame} = [med_vert_frames{frame},med_vert_frames20{frame}];%this is where you change to concatenate two arrays
end

all_mhf=cell(length(med_horz_frames),1);
for frame = 1:length(med_horz_frames)
    all_mhf{frame} = [med_horz_frames{frame},med_horz_frames20{frame}];%this is where you change to concatenate two arrays
end

all_svf=cell(length(short_vert_frames),1);
for frame = 1:length(short_vert_frames)
    all_svf{frame} = [short_vert_frames{frame},short_vert_frames20{frame}];%this is where you change to concatenate two arrays
end

all_shf=cell(length(short_horz_frames),1);
for frame = 1:length(short_horz_frames)
    all_shf{frame} = [short_horz_frames{frame},short_horz_frames20{frame}];%this is where you change to concatenate two arrays
end

%% this will compute the average and standard deviation from all mice at each frame

avg_all_bhf = [];
avg_all_bvf = [];
avg_all_lhf = [];
avg_all_lvf = [];
avg_all_mhf = [];
avg_all_mvf = [];
avg_all_shf=[];
avg_all_svf = [];

std_all_bhf =[];
std_all_bvf=[];
std_all_lhf =[];
std_all_lvf=[];
std_all_mhf =[];
std_all_mvf=[];
std_all_shf =[];
std_all_svf=[];

for frame=1:numel(all_bhf)
    avg_all_bhf(frame)=mean(all_bhf{frame});
    std_all_bhf(frame)=std(all_bhf{frame});
end

for frame=1:numel(all_bvf)
    avg_all_bvf(frame)=mean(all_bvf{frame});
    std_all_bvf(frame)=std(all_bvf{frame});
end

for frame=1:numel(all_lhf)
    avg_all_lhf(frame)=mean(all_lhf{frame});
    std_all_lhf(frame)=std(all_lhf{frame});
end

for frame=1:numel(all_lvf)
    avg_all_lvf(frame)=mean(all_lvf{frame});
    std_all_lvf(frame)=std(all_lvf{frame});
end

for frame=1:numel(all_mhf)
    avg_all_mhf(frame)=mean(all_mhf{frame});
    std_all_mhf(frame)=std(all_mhf{frame});
end

for frame=1:numel(all_mvf)
    avg_all_mvf(frame)=mean(all_mvf{frame});
    std_all_mvf(frame)=std(all_mvf{frame});
end

for frame=1:numel(all_shf)
    avg_all_shf(frame)=mean(all_shf{frame});
    std_all_shf(frame)=std(all_shf{frame});
end

for frame=1:numel(all_svf)
    avg_all_svf(frame)=mean(all_svf{frame});
    std_all_svf(frame)=std(all_svf{frame});
end

%% save everything - the way the combimedplotAVGopto.py file works you need continuous and burst stimulation saved separately. 
%change the save file names!!!

save_file_name='/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDavgvalues';

save(save_file_name, 'avg_all_svf','avg_all_shf', 'avg_all_mvf', 'avg_all_mhf', 'avg_all_lhf', 'avg_all_lvf', '-mat')

burst_file_name='/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDBURSTavgvalues';

save(burst_file_name, 'avg_all_bhf', 'avg_all_bvf', '-mat')

save_STD_name='/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDstd';

save(save_STD_name, 'std_all_svf', 'std_all_shf', 'std_all_mvf', 'std_all_mhf', 'std_all_lvf', 'std_all_lhf', '-mat')

burst_STD_name='/Users/jordanmccarthy/Desktop/licking/opto/COMBINEDBURSTstd';

save(burst_STD_name,  'std_all_bvf', 'std_all_bhf', '-mat')