function [Feature,freq,freqFeatures_t] = get_feature(bearingFulldata)


data_idx = width(bearingFulldata);
for i = 1:2104
freq(:,i) = getFFT(bearingFulldata(:,i),8192);
end

timeFeatures_t  = table;
freqFeatures_t  = table;


for i = 1 : data_idx
    timeFeatures_t = [timeFeatures_t ; timeFeatures_LAB(bearingFulldata(:, i))];
    freqFeatures_t = [freqFeatures_t ; freqFeatures(freq(:, i))];
end

Feature = table2array([timeFeatures_t freqFeatures_t]);

end