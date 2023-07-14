%{
The intan file is a binary file where all 16 digital inputs are packed
together into a 16-bit number at each timestamp (sampled at 30000 Hz). So
if the first two digital inputs are high, the value would look like this:

0000000000000011

if all were high, it would look like this

1111111111111111

We want to read all of the 16-bit entries (one for each timestamp) and
separate them out for all digital inputs. We can then find all of the
low-to-high transitions as our TTL "times"

%}

clear all

filename = '/Users/jordanmccarthy/Desktop/licking/Phox2B_#23/20230627/digitalin.dat';
save_file_name = '/Users/jordanmccarthy/Desktop/Phox2B_#23_2023_0627_ttl_times.mat';

file = fopen(filename,'r');
digital_inputs_raw = fread(file,'uint16');
fclose(file);

digital_inputs = cell(16,1);
ttl_times = cell(16,1);

for i=1:16
    digital_inputs{i} = bitand(digital_inputs_raw,(2^(i-1)));
    ttl_times{i} = find(diff(digital_inputs{i})>0);
end

save(save_file_name,'ttl_times');


%% use ttl information to create a cell array of frames corresponding to drinking periods
% ttl_times{4} marks the beginning of the drinking period each time

%establish the camera frame numbers that begin the drinking period
startFrame = zeros(length(ttl_times{4}),1);

for i= 1:length(ttl_times{4})
    [~,index] = min(abs(ttl_times{1}-ttl_times{4}(i)));
    startFrame(i) = index;
end

% create a cell array for each trial's drinking period where each row
% corresponds to one trial and inside is all of the frames during the
% drinking period

drinkingPeriods = cell (length(startFrame),1);

%this creates cells that are 1*1751, to have only exactly 1750 frames can
%add 1749 instead if needed

for trial = 1:length(startFrame)
    drinkingPeriods{trial} = [startFrame(trial):startFrame(trial)+1750];
end

%% create cell arrays for the sampling periods (have to run drinking periods first)
%find start of sampling period (auditory cue is ttl_times3)

startSample = zeros(length(ttl_times{3}),1);

for j=1:length(ttl_times{3})
    [~,index] = min(abs(ttl_times{1}-ttl_times{3}(j)));
    startSample(j) = index;
end

%create cell array of sampling periods. since sampling periods vary in time
%and may or may not end with a drinking period, this checks if there is a
%drinking period within 10s and if not makes the sampling period 10s
%(10*350fps)

samplingPeriods = cell(length(startSample),1);

for period = 1:length(samplingPeriods)
    matches = find(startFrame>startSample(period)&startFrame<startSample(period)+3500);
    if isempty(matches)
        samplingPeriods{period}=startSample(period):startSample(period)+3500;
    else 
        samplingPeriods{period}=startSample(period):startFrame(matches);
    end
end 


%% info to make raster plot

LickTimes = cell(length(ttl_times{3}),1);

% organize licks into trials

for k=1:length(ttl_times{3})
    for f=1:length(ttl_times{2})
        %finds the last trial's licks
     if k==length(ttl_times{3})
        if ttl_times{2}(f)>= ttl_times{3}(k)
             LickTimes{k}=[LickTimes{k},ttl_times{2}(f)];
        end
     else
         %finds licks in every other trial
              if ttl_times{2}(f) >= ttl_times{3}(k) && ttl_times{2}(f)<ttl_times{3}(k+1)
                 LickTimes{k}=[LickTimes{k},ttl_times{2}(f)];
              end
     end
    end
     LickTimes{k}=LickTimes{k}-ttl_times{3}(k); %set cue to 0
     LickTimes{k}=LickTimes{k}/30000; %divide by intan frame rate for time in seconds
end

% trial structure intan frames 

Cues = ttl_times{3}/30000; %puts cues into seconds
Water = ttl_times{4}/30000; %puts water delivery into seconds

%find water delivery time for each trial
for w=1:length(Water)
    for c=1:length(Cues)
        if Water(w)-Cues(c)<10 && Water(w)-Cues(c)>0 %10s is the sampling period
            Water(w)=Water(w)-Cues(c);
        end
    end
end

%set cues to zero
Cues=zeros(length(ttl_times{3}),1);


% define save file name
name = '/Users/jordanmccarthy/Desktop/licking/Phox2B_#23/20230627/rasterplotinfo';

save(name, 'LickTimes', 'Water', 'Cues')
