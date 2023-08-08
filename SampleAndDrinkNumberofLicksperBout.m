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

%% plot peaks from sampling+drinking period

[peaks,locs] = findpeaks(smoothdata(areas,'gaussian', 12),'MinPeakDistance',17.5, 'MinPeakHeight',200);

%initializes new arrays for the peaks and location of peaks only in the
%sampling and drinking period
sd_peaks = [];
sd_locs = [];

%loop through all drinking period frames and peaks/locations and put peaks
%and locations in the drinking period into new arrays
for i=1:length(peaks)
    for j=1:numel(SampleDrinkPeriods)
        if locs(i) >= SampleDrinkPeriods{j}(1) && locs(i)<= SampleDrinkPeriods{j}(end)
        sd_peaks = [sd_peaks; peaks(i)];
        sd_locs = [sd_locs; locs(i)];
        end
    end 
end

% you want to save the sd_peaks variable manually because it is the
% amplitude of licking

%plot only peaks in drinking periods on graph of all data to check this
%worked
figure
plot(smoothdata(areas,'gaussian', 12));
hold on;
scatter(sd_locs, sd_peaks,'bv', 'filled');
xlabel('Frames');
ylabel('Areas');

%% create aggregates and calculate licks per bout
% time window for consecutive spikes. 70 frames = 200ms corresponds to 5Hz 

% Peak locations (in frames) - this makes the locations of peaks it
% analyzes only the ones int eh sampling and drinking period
peak_locs = sd_locs;

% maximum distance between peaks to be considered in the same aggregate -
% can be adjusted but this is that the licks have to be more than 200ms
% apart to start a new bout
max_distance = 70;

% this is directly from Jun's NumberofLIcksPerBout

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

%you want to manually save the num_peaks array as this is number of licks
%per bout that you can plot in a histogram

% this will calculate the mean number of licks per bout for the drinking
% and sampling periods in a session
LickPerBout = mean(num_peaks);
%% Find licking frequency of bouts above the threshold

length_threshold = 3; %you can change this to change how many licks need to be in a bout to calculate frequency and Interlick Interval

multi_agg_locs = [];

%create a new array of bouts above the threshold
for w=1:numel(agg_locs)
    if length(agg_locs{w})>=length_threshold
    multi_agg_locs{w} = agg_locs{w};
    end
end

%gets rid of any empty cells 
multi_agg_locs = multi_agg_locs(~cellfun('isempty', multi_agg_locs));

%find the licking frequency
for l=1:numel(multi_agg_locs)
    agg_length(l) = (multi_agg_locs{l}(end)-multi_agg_locs{l}(1))/350;
    agg_num(l) = length(multi_agg_locs{l});
    agg_freq(l) = agg_num(l)/agg_length(l);
end

%if you want to compare licking frequency, manually save the agg_freq
%variable

FrequencyOfLick = mean(agg_freq);

disp(['The licking frequency is ', num2str(FrequencyOfLick), ' and there are ', num2str(LickPerBout), ' licks per bout.'])

%% Inter Lick Interval for drinking period licks - this is directly from Jun's NumberofLicksPerBout
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