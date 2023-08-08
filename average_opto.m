%% organize data into trials - requires LaserStim from read_intan.mat and all the jaw data from opto_traces.mat

%makes sure the inputs from opto_traces.mat are in the double format so the
%code works
Heights=double(Heights);
Widths=double(Widths);

%creates new arrays with the heights data - either vertical position or
%horizontal position - for the length of laser stimulation plus a bit extra
VertStimTrials = cell(length(LaserStim),1);

for s=1:9
    start_laser=LaserStim(s);
    end_laser=LaserStim(s)+150;
    VertStimTrials{s}=Heights(start_laser:end_laser);
end
for m=10:18
    start_laser=LaserStim(m);
    end_laser=LaserStim(m)+225;
    VertStimTrials{m}=Heights(start_laser:end_laser);
end
for l=19:27
    start_laser=LaserStim(l);
    end_laser=LaserStim(l)+500;
    VertStimTrials{l}=Heights(start_laser:end_laser);
end


HorzStimTrials = cell(length(LaserStim),1);

for s=1:9
    start_laser=LaserStim(s);
    end_laser=LaserStim(s)+150;
    HorzStimTrials{s}=Widths(start_laser:end_laser);
end
for m=10:18
    start_laser=LaserStim(m);
    end_laser=LaserStim(m)+225;
    HorzStimTrials{m}=Widths(start_laser:end_laser);
end
for l=19:27
    start_laser=LaserStim(l);
    end_laser=LaserStim(l)+500;
    HorzStimTrials{l}=Widths(start_laser:end_laser);
end

%% find the average value and standard deviation at each frame

%avg value
short_avg_vert=zeros(151,1);
short_vert_frames=cell(151,1);

for f=1:151
    for t=1:9
        short_avg_vert(f)=short_avg_vert(f)+VertStimTrials{t}(f,:);
        short_vert_frames{f}=[short_vert_frames{f},VertStimTrials{t}(f,:)];
    end
    short_avg_vert(f)=short_avg_vert(f)/9;
end

%stddev
short_vert_STDdevs=[];
for f=1:151
    STD=std(short_vert_frames{f});
    short_vert_STDdevs=[short_vert_STDdevs,STD];
end

%avg value
short_avg_horz=zeros(151,1);
short_horz_frames=cell(151,1);

for f=1:151
    for t=1:9
        short_avg_horz(f)=short_avg_horz(f)+HorzStimTrials{t}(f,:);
        short_horz_frames{f}=[short_horz_frames{f},HorzStimTrials{t}(f,:)];
    end
    short_avg_horz(f)=short_avg_horz(f)/9;
end

%stddev
short_horz_STDdevs=[];
for f=1:151
    STD=std(short_horz_frames{f});
    short_horz_STDdevs=[short_horz_STDdevs,STD];
end

%repeats the previous code but for the 0.5s trials
med_avg_vert=zeros(226,1);
med_vert_frames=cell(226,1);

for f=1:226
    for t=10:18
        med_avg_vert(f)=med_avg_vert(f)+VertStimTrials{t}(f,:);
        med_vert_frames{f}=[med_vert_frames{f},VertStimTrials{t}(f,:)];
    end
    med_avg_vert(f)=med_avg_vert(f)/9;
end

med_vert_STDdevs=[];
for f=1:226
    STD=std(med_vert_frames{f});
   med_vert_STDdevs=[med_vert_STDdevs,STD];
end

med_avg_horz=zeros(226,1);
med_horz_frames=cell(226,1);

for f=1:226
    for t=10:18
        med_avg_horz(f)=med_avg_horz(f)+HorzStimTrials{t}(f,:);
        med_horz_frames{f}=[med_horz_frames{f},HorzStimTrials{t}(f,:)];
    end
    med_avg_horz(f)=med_avg_horz(f)/9;
end

med_horz_STDdevs=[];
for f=1:226
    STD=std(med_horz_frames{f});
   med_horz_STDdevs=[med_horz_STDdevs,STD];
end

%repeats the previous code for the 1s continuous trials
long_avg_vert=zeros(501,1);
long_vert_frames=cell(501,1);

for f=1:501
    for t=19:27
        long_avg_vert(f)=long_avg_vert(f)+VertStimTrials{t}(f,:);
        long_vert_frames{f}=[long_vert_frames{f},VertStimTrials{t}(f,:)];
    end
    long_avg_vert(f)=long_avg_vert(f)/9;
end

long_vert_STDdevs=[];
for f=1:501
    STD=std(long_vert_frames{f});
   long_vert_STDdevs=[long_vert_STDdevs,STD];
end

long_avg_horz=zeros(501,1);
long_horz_frames=cell(501,1);

for f=1:501
    for t=19:27
        long_avg_horz(f)=long_avg_horz(f)+HorzStimTrials{t}(f,:);
         long_horz_frames{f}=[long_horz_frames{f},HorzStimTrials{t}(f,:)];
    end
    long_avg_horz(f)=long_avg_horz(f)/9;
end

long_horz_STDdevs=[];
for f=1:501
    STD=std(long_horz_frames{f});
   long_horz_STDdevs=[long_horz_STDdevs,STD];
end

%% if you want to combine all of the raw (not-averaged) data to combine two mice using optocombined.mat, use this save - don't forget to change save name! (first item in parenthesis)

save('/Users/jordanmccarthy/Desktop/licking/opto/#21continframedata', 'long_horz_frames','long_vert_frames', 'short_horz_frames', 'short_vert_frames','med_horz_frames', 'med_vert_frames')

%% saving the average heights/widths and standard deviations - change the save name! 

save_data_name='/Users/jordanmccarthy/Desktop/licking/opto/Phox2B_#21_avgoptodata';
save(save_data_name,'short_avg_vert','short_avg_horz','med_avg_vert','med_avg_horz','long_avg_vert','long_avg_horz', '-mat')

save_STD_name='/Users/jordanmccarthy/Desktop/licking/opto/Phox2B_#21_avgSTDopto';
save(save_STD_name, 'short_vert_STDdevs','short_horz_STDdevs','med_vert_STDdevs','med_horz_STDdevs','long_vert_STDdevs','long_horz_STDdevs','-mat');


%% burst - only the 1s ones

%checks the input from opto_traces.mat is in the right format to plot
Heights=double(Heights);
Widths=double(Widths);

%since this only wants the 1s burst trials, this laser pulse ttl_times starts of
%each of the 9 times it bursts (there are 11 pulses in one burst) - if the
%bpod program doesn't change, these numbers will be the same
long=[73,84,95,106,117,128,139,150,161];

%all of this repeats the code above but for the 1s burst
VertBurstTrials = cell(9,1);

i=1;
for l=long
    start_laser=LaserStim(l);
    end_laser=LaserStim(l)+600;
    VertBurstTrials{i}=Heights(start_laser:end_laser);
    i=i+1;
end

HorzBurstTrials = cell(9,1);

j=1;
for l=long
    start_laser=LaserStim(l);
    end_laser=LaserStim(l)+600;
    HorzBurstTrials{j}=Widths(start_laser:end_laser);
    j=j+1;
end

%avg value
burst_avg_vert=zeros(601,1);
burst_vert_frames=cell(601,1);

for f=1:601
    for t=1:9
        burst_avg_vert(f)=burst_avg_vert(f)+VertBurstTrials{t}(f,:);
        burst_vert_frames{f}=[burst_vert_frames{f},VertBurstTrials{t}(f,:)];
    end
    burst_avg_vert(f)=burst_avg_vert(f)/9;
end

%stddev
burst_vert_STDdevs=[];
for f=1:601
    STD=std(burst_vert_frames{f});
    burst_vert_STDdevs=[burst_vert_STDdevs,STD];
end

%avg value
burst_avg_horz=zeros(601,1);
burst_horz_frames=cell(601,1);

for f=1:601
    for t=1:9
        burst_avg_horz(f)=burst_avg_horz(f)+HorzBurstTrials{t}(f,:);
        burst_horz_frames{f}=[burst_horz_frames{f},HorzBurstTrials{t}(f,:)];
    end
    burst_avg_horz(f)=burst_avg_horz(f)/9;
end

%stddev
burst_horz_STDdevs=[];
for f=1:601
    STD=std(burst_horz_frames{f});
    burst_horz_STDdevs=[burst_horz_STDdevs,STD];
end

%% - if you want to have the raw (not averaged) data to put in optocombined use this save and change the name!

save('/Users/jordanmccarthy/Desktop/licking/opto/#21framesburstdata', 'burst_horz_frames', 'burst_vert_frames')

%% this will save the average heights/widths and standard deviations for plotting a graph with just this mouse - change the save name!
save_burstdata_name='/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/burst_avgoptodata_#21';
save(save_burstdata_name, 'burst_avg_horz', 'burst_avg_vert', '-mat')

save_burstSTD_name='/Users/jordanmccarthy/Desktop/licking/opto/Phox2B#21/burst_avgSTDdata_#21';
save(save_burstSTD_name, 'burst_horz_STDdevs', 'burst_vert_STDdevs','-mat')