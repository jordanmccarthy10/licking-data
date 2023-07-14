Edges = [1,2,3,4,5,6,7,8,9,10, 11];

maxlicks = 10;

hist_peaks = 1:length(num_peaks);
for i=1:length(num_peaks)
    if num_peaks(i)>maxlicks
        hist_peaks(i)=11;
    else
        hist_peaks(i)=num_peaks(i);
    end
end

figure 
hist(hist_peaks, Edges)
title(['Number of Licks Per Bout for Phox2B #23 Before Surgery'])
xlabel('Number of Licks Per Bout')
ylabel('Occurence')