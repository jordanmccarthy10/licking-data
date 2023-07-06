clear
%% Read h5 files. This function is in /Users/jun/Documents/Work/Project/Licking/Analysis_Code
[areas, Jaw_heights] = extract_h5();
%% Plot traces for inspection
% use (smoothdata(areas,'gaussian', 12)) for plotting small time window. if
% no parameter is set, this command makes trace too smooth. Or consider to
% use different kind of filters.

plot(smoothdata(areas,'gaussian', 12))
hold on
plot(5*smoothdata(Jaw_heights{1},'gaussian', 12))
ylim([0 15000])

% %%
% %graph only from drinking periods
% a = smoothdata(areas,'gaussian', 12);
% j = 5*smoothdata(Jaw_heights{1},'gaussian', 12);
% tongue_data = [];
% jaw_data = [];
% 
% figure
% hold on
% for i=1:numel(drinkingPeriods)
%     trial = drinkingPeriods{i};
%     tongue_interval = a(trial(1):trial(end));
%     tongue_data = vertcat(tongue_data,tongue_interval);
%     jaw_interval = j(trial(1):trial(end));
%     jaw_data = vertcat(jaw_data,jaw_interval);
%     i = i+1;
% end
%     plot(tongue_data)
%     plot(jaw_data)
%     xlim([0,1750*numel(drinkingPeriods)]);
%     ylim([0,15000]);
%     xlabel('Frame');
%     ylabel('areas');

%% plot only peaks from the drinking period (drinking_locs and drinking_peaks)on graph of all data

[peaks,locs] = findpeaks(smoothdata(areas,'gaussian', 12),'MinPeakDistance',17.5, 'MinPeakHeight',200);

drinking_peaks = [];
drinking_locs = [];

%loop through all drinking period frames and peaks/locations and put peaks
%and locations in the drinking period into new vectors
for i=1:length(peaks)
    for j=1:numel(drinkingPeriods)
        if locs(i) >= drinkingPeriods{j}(1) && locs(i)<= drinkingPeriods{j}(end)
        drinking_peaks = [drinking_peaks; peaks(i)];
        drinking_locs = [drinking_locs; locs(i)];
        end
    end 
end

%plot only peaks in drinking periods on graph of all data
figure
plot(smoothdata(areas,'gaussian', 12));
hold on;
scatter(drinking_locs, drinking_peaks,'bv', 'filled');
xlabel('Frames');
ylabel('Areas');

%% plot amplitudes from drinking periods aligned to start of trial

%shortens name of areas data for ease
a = smoothdata(areas,'gaussian', 12);
%initiates new cell arrays to put areas data versus its frame normalized to
%start of trial
trial_licks = cell(numel(drinkingPeriods),1);
trial_locs = cell(numel(drinkingPeriods),1);

%puts the areas data for each trial into cell arrays
for t=1:numel(drinkingPeriods)
           trial_licks{t}=vertcat(trial_licks{t},a(drinkingPeriods{t}(1):drinkingPeriods{t}(end)));
           trial_locs{t}=[1:1:1751];
end

%plot all of the areas traces overlapping
figure
for h=1:numel(trial_licks)
    plot(trial_locs{h}, trial_licks{h})
    hold on
end 

%% plot mean amplitude at each frame over all trials
avg_trial_licks = zeros(1751,1);

%find the mean amplitude at each frame
for d=1:1751
    for p=1:numel(trial_licks)
    avg_trial_licks(d)=avg_trial_licks(d)+trial_licks{p}(d,:);
    end
    avg_trial_licks(d)=avg_trial_licks(d)/numel(trial_licks);
end

% finding stddev at each frame
frames = cell(1751,1);

for f=1:1751
    for p=1:numel(trial_licks)
        frames{f}= [frames{f}; trial_licks{p}(f,:)];
    end
end

%SEMs= [];
stdDevs = [];
for f=1:1751
    stdDev=std(frames{f});
    stdDevs = [stdDevs; stdDev];
%     SEM=stdDev/sqrt(length(frames{f}));
%     SEMs = [SEMs; SEM];
end 

% %create new matrices with the upper and lower SEM values
% upperSEM = zeros(1,1751);
% lowerSEM = zeros(1,1751);
% for f=1:1751
% upperSEM(1,f) = avg_trial_licks(f)+SEMs(f);
% lowerSEM(1,f) = avg_trial_licks(f)-SEMs(f);
% end 

upperSTD = zeros(1,1751);
lowerSTD = zeros(1,1751);
for f=1:1751
upperSTD(1,f) = avg_trial_licks(f)+stdDevs(f);
lowerSTD(1,f) = avg_trial_licks(f)-stdDevs(f);
end 

%plot the mean data with the stddev shaded in around the line
figure
hold on
plot(avg_trial_licks, 'b')
fill([trial_locs{1},fliplr(trial_locs{1})],[lowerSTD, fliplr(upperSTD)],'b','EdgeColor', 'b', 'EdgeAlpha', 0.2, 'FaceAlpha', 0.2)
xlabel('Frames')
ylabel('Areas')
title('Mean Amplitude of Licking with stddev across all trials')


%% plot the normalized amplitude of licking for all trials
norm_trial_licks = cell(numel(trial_licks),1);
for v=1:numel(trial_licks)
    for b=1:1751
        g=max(trial_licks{v});
        norm_trial_licks{v}(b)=trial_licks{v}(b)/g;
    end
end

figure
for v=1:numel(trial_licks)
plot(norm_trial_licks{v}+v)
hold on
end 
ylim([0,numel(norm_trial_licks)+5])
xlabel('Frames')
ylabel('Trial')
title('Normalized licking amplitude across all trials')
%% create aggregates and calculate licks per bout
% time window for consecutive spikes. 70 frames = 200ms corresponds to 5Hz 

% Peak locations (in frames)
peak_locs = drinking_locs;

% maximum distance between peaks to be considered in the same aggregate
max_distance = 70;

% initialize variables
agg_count = 0;
peak_count = 0;
agg_locs = [];
num_peaks = [];

% loop through each peak location
for i = 1:length(peak_locs)
    
    % if this is the first peak, initialize the aggregate
    if peak_count == 0
        agg_count = agg_count + 1;
        agg_locs{agg_count} = peak_locs(i);
        peak_count = peak_count + 1;
        
    % if this peak is within the maximum distance of the previous peak,
    % add it to the same aggregate
    elseif peak_locs(i) - agg_locs{agg_count}(end) <= max_distance
        agg_locs{agg_count} = [agg_locs{agg_count} peak_locs(i)];
        peak_count = peak_count + 1;
        
    % if this peak is too far from the previous peak, start a new aggregate
    else
        % store the number of peaks in the previous aggregate
        num_peaks(agg_count) = peak_count;
        
        agg_count = agg_count + 1;
        agg_locs{agg_count} = peak_locs(i);
        peak_count = 1;
    end
    
end

% store the number of peaks in the final aggregate
num_peaks(agg_count) = peak_count;

% print the aggregate locations and number of peaks
for i = 1:length(agg_locs)
    fprintf('Aggregate %d contains %d peaks: %s\n', ...
        i, num_peaks(i), mat2str(agg_locs{i}));
end

LickPerBout = mean(num_peaks);
%% Inter Lick Interval
InterLick_interval = diff(peak_locs);
InterLick_interval = InterLick_interval(InterLick_interval <= 700); % cut off 2 second
InterLick_interval_InSecond = InterLick_interval/350;
InterLick_interval_InMillisecond = InterLick_interval_InSecond*1000;

[histFreq, histXout] = hist(InterLick_interval_InMillisecond, 100); % 20 ms bin 
figure;
bar(histXout, histFreq/sum(histFreq)*100);
xlabel('Inter Lick Interval (ms)');
ylabel('Probability');

xlim([0,2000]);
ylim([0,50]);