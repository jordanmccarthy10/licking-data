Edges = [2,3,4,5,6,7,8,9]; %pick a scale

figure
hist(agg_freq)
title("Licking Frequency for Phox2B#23 13 days post op")
xlabel('Frequency')
ylabel('Occurence')

%%should make everything percentages by dividing the occurrence of each
%%number by the total number of data points somehow