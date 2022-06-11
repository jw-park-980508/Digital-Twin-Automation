function statical_table = statical_data(x1,x2, kind)
%UNTITLED3 이 함수의 요약 설명 위치
%   자세한 설명 위치
% x1 = X118_DE_time;
% x2 = X118_FE_time;
% kind = "ball";

Class_table = table(kind,'VariableNames', "Class");

N = 120000;
index2 = N / 30 ; 
index = N / 15;

time = timeFeatures_LAB(1);
freq = freqFeatures(1);

time_var = string(time.Properties.VariableNames);
freq_var = string(freq.Properties.VariableNames);

var = [("DE "+time_var) ("DE "+freq_var) ("FE "+time_var) ("FE "+freq_var)];

Statistic_table_init = zeros(1,26);
statical_table_temp = array2table(Statistic_table_init,'VariableNames', var);
statical_table = [statical_table_temp Class_table];

x1_freq = getFFT(x1,N);
x2_freq = getFFT(x2,N);

for i = 1:15
    
    x1_time_features = timeFeatures_LAB(x1((i-1)*index + 1 : i*index));
    x1_freq_features = freqFeatures(x1_freq((i-1)*index2 + 1 : i*index2));
    
    x2_time_features = timeFeatures_LAB(x2((i-1)*index + 1 : i*index));
    x2_freq_features = freqFeatures(x2_freq((i-1)*index2 +1 : i*index2));

    statical_feature = [table2array(x1_time_features) table2array(x1_freq_features) table2array(x2_time_features) table2array(x2_freq_features)];
    Table_temp = array2table(statical_feature,'VariableNames', var );  
    Table = [Table_temp Class_table];
    
    statical_table = [statical_table ; Table];
end

statical_table(1,:) = [];

end

