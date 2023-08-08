clear

%this could probably be combined with average_opto.m and avoid having to
%switch matlab files, but this can only run on the behavior computer and
%the other one can run on any computer
%% get height, width, 'displacement'
[areas, Jaw_heights, Jaw_widths] = extract_h5();

%makes sure data is in the right format - it wouldn't work otherwise
Heights=int16(Jaw_heights{1});
Widths=int16(Jaw_widths{1});

%because top left is zero instead of bottom left, flip the heights values
%so bottom is 0
for c=1:length(Heights)
    Heights(c)=480-Heights(c);
end

dVert=[];
dHorz=[];
dVert2=[];
dHorz2=[];

% %calculates 'displacement' as the sqrt of x and y value squared - this one
% %is less useful and I didn't use it for any plotting
% for c=1:length(Heights)
%     dVert(c)=int16(Heights(c));
%     dHorz(c)=int16(Widths(c));
%    dVert2(c)=dVert(c)^2;
%    dHorz2(c)=dHorz(c)^2;
%    Jaw_displacement(c)=sqrt(dVert2(c)+dHorz2(c));
% end

%% save the heights and widths values - don't forget to change the name!
% save data
save_file_name = '/home/wanglab/Programs/NewSystem/Phox2B_#21_opto_burst_0.11mW_2023_0630_jawdata';

save(save_file_name, "Heights","Widths", '-mat')

%% plot data to check if it worked
figure
plot(smoothdata(Widths, 'gaussian', 5), 'b')
hold on
plot(Jaw_displacement, 'm')
plot(smoothdata(Heights, 'gaussian',5), 'r')
%xline(LaserStim, 'r')
for r=1:length(LaserStim)
rectangle('Position', [LaserStim(r),0,17.5,1200])
end
hold off
