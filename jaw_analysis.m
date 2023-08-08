clear
%% NOTES - read me
%This code requires you to put in SampleDrinkPeriods from the read_intan.m
%file - drag and drop into the workspace. 
% 
% this code also misses the first
%and last peak in the jaw data because of the way it seperates everything into licking
%periods starting from the first and ending at the last peak of the tongue
%data. that means it does not calculate jaw amplitude for single or double
%licks (because there are no peaks to match the minimum with. if the mouse
%has a significant amount of single or double licks, this code will not be
%reliable

%there are also lots of parameters (min peak distance and prominence ) that
%need manual adjustment

%at the end, you can set the save file name and take the jaw amplitudes
%variable into python
%% this is a function - need the file in the directory
[areas,Jaw_heights]=extract_h5();

%% Plot traces for inspection
% use (smoothdata(areas,'gaussian', 12)) for plotting small time window. if
% no parameter is set, this command makes trace too smooth. Or consider to
% use different kind of filters.

plot(smoothdata(areas,'gaussian', 12))
hold on
plot(5*smoothdata(Jaw_heights{1},'gaussian', 12))
ylim([0 15000])

%% Separate out tongue and jaw data from only sampling and drinking periods

%redefine jaw and tongue data from extract_h5 to make code shorter and
%preserve original variables
a = smoothdata(areas,'gaussian', 12);
j = 5*smoothdata(Jaw_heights{1},'gaussian',12);
tongue_data = [];
jaw_data = [];

%you need the SampleDrinkPeriods variable from read_intan to run this!
for i=1:numel(SampleDrinkPeriods)
    trial = SampleDrinkPeriods{i};
    tongue_interval = a(trial(1):trial(end));
    tongue_data = vertcat(tongue_data,tongue_interval);
    jaw_interval = j(trial(1):trial(end));
    jaw_data = vertcat(jaw_data,jaw_interval);
    i =i+1;
end

figure
hold on
    plot(tongue_data)
    plot(jaw_data)
    xlim([0,1750*numel(SampleDrinkPeriods)]);
    ylim([0,15000]);
    xlabel('Frame');
    ylabel('areas');

%% define licking periods based on peaks in the tongue data and then create licking windows

%find peak of licks in sampling/drinking period
[peaks,locs] = findpeaks(tongue_data,'MinPeakDistance',17.5, 'MinPeakHeight',200);

LickBouts = [];

max_distance = 70;

bout = 1;

%group the peaks into the bouts of licking
for p = 1:length(locs)
    if p==1 %start the first bout
        LickBouts{1}(1) = locs(1);
    elseif p-1>0&&locs(p)-locs(p-1)<=max_distance
        LickBouts{bout} = [LickBouts{bout},locs(p)];
    elseif p-1>0&&locs(p)-locs(p-1)>max_distance %start a new bout if it's more than .2s apart from the last lick
        bout = bout+1;
        LickBouts{bout}(1)= locs(p);
    end
end

%define the frames that encompass the licking windows (we do miss the first half of the first lick and last half of the last lick)

LickingWindows = cell(numel(LickBouts),1);

for w=1:length(LickingWindows)
    LickingWindows{w}=[LickBouts{w}(1):1:LickBouts{w}(end)];
end

% check that the licking windows is correct (licking windows in red - you expect to miss single peaks (only 1 frame) and half of first and last peak
figure
hold on
plot(tongue_data)
plot(locs,peaks, '^')
for w=1:length(LickingWindows)
    plot(LickingWindows{w}(1:end),tongue_data(LickingWindows{w}(1:end)), color='red')
end

% check that the licking windows is also correct on the jaw - both open
% just move the top one over to see both
figure
hold on
plot(jaw_data)
plot(tongue_data, color='#808080')
for w=1:length(LickingWindows)
    plot(LickingWindows{w}(1:end),jaw_data(LickingWindows{w}(1:end)), color='red')
end

%% create new arrays of the tongue data only during the licking windows
jaw_data_bouts = cell(length(LickingWindows),1); %this is now going to be the actual data points determined from the licking windows frames
nanArray = NaN(40,1);


for w=1:numel(LickingWindows)
    jaw_data_bouts{w}=jaw_data(LickingWindows{w}(1:end));
    jaw_data_bouts{w}=vertcat(jaw_data_bouts{w},nanArray); %add a NaN to separate the bouts from each other so peaks doesn't get messed up by going straight into the next bout
end

jaw_data_licking = [];

for w=1:numel(jaw_data_bouts)
    jaw_data_licking = vertcat(jaw_data_licking,jaw_data_bouts{w});
end

%this finds peaks at least 50ms apart and at least 20 units above their
%nearest surrounding troughs - this parameter can be adjusted but it is
%used to avoid very minor peaks (such as tracking blips) being counted and seems to capture the true
%peaks in the data
[jaw_peaks,jaw_locs]=findpeaks(jaw_data_licking, 'MinPeakDistance',17.5,'MinPeakProminence',20);

figure
hold on
plot(jaw_data_licking)
plot(jaw_locs,jaw_peaks,'^')

%% to find the minimum points to be able to compare the jaw movement

%find mins by inverting the data and finding peaks
min_jaw_data = -jaw_data_licking;
[jaw_mins_inv,jaw_mins_locs]=findpeaks(min_jaw_data, 'MinPeakDistance',17.5, 'MinPeakProminence',40); %min peak prominence selected to reduce # of false peaks, can be adjusted

% %check that it found points properly
% figure
% hold on
% plot(min_jaw_data)
% plot(jaw_mins_locs,jaw_mins_inv,'^')
% hold off

%finding the actual mins by indexing back into the original data
jaw_mins = jaw_data_licking(jaw_mins_locs);

%check that this worked properly
figure
hold on
plot(jaw_data_licking)
plot(jaw_locs, jaw_peaks,'^c')
plot(jaw_mins_locs,jaw_mins,'^g')

%% get the min and peak pairings

%creates cell arrays for the pairings of locations of matching mins and
%peaks and the values in them
jaw_pairs_locs = cell(length(jaw_locs),1);
jaw_pairs = cell(length(jaw_locs),1);

%loops through the locations of peaks and finds the nearest location of a
%minimum and then stores the locations and actual values in separate arrays
for point=1:length(jaw_locs)
    match = find(jaw_mins_locs>jaw_locs(point) & jaw_mins_locs-jaw_locs(point)<=50,1);
    jaw_pairs_locs{point}=[jaw_locs(point),jaw_mins_locs(match)];
    jaw_pairs{point}=[jaw_peaks(point),jaw_mins(match)]; %for some reason this also gives some points without a jaw_min
end

%check that the pairings are good
figure 
hold on
plot(jaw_data_licking,color='#808080')
for point=1:length(jaw_pairs)
    plot(jaw_pairs_locs{point},jaw_pairs{point})
end

%% get the amplitudes
jaw_amplitudes = [numel(jaw_pairs),1];

for point=1:length(jaw_pairs)
    if length(jaw_pairs{point})==2
    jaw_amplitudes(point)=jaw_pairs{point}(1)-jaw_pairs{point}(2);
    else
        jaw_amplitudes(point)=NaN; %makes sure points without a corresponding jaw_min are not included
    end
end

jaw_amplitudes=jaw_amplitudes(~isnan(jaw_amplitudes));

save_var_name = ('/Users/jordanmccarthy/Desktop/jawamplitudes#22silencing0718');

save(save_var_name,"jaw_amplitudes",'-mat')
