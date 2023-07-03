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

filename = '/Users/jordanmccarthy/Desktop/licking/ILPG_Silencing_Di_#4/20230622/digitalin.dat';
save_file_name = '/Users/jordanmccarthy/Desktop/ttl_timesDi#4.mat';

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

