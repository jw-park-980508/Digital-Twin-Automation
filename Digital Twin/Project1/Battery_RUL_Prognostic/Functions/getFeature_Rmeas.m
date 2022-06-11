function [Feature_Rmeas] = getFeature_Rmeas(data) 

% Input : data(B005, B006, etc....)
% Output : Rmeas(Feature) according to input data

j        = 0;
len      = length(data.cycle);
data_idx = zeros(1,1);

% 보고자 하는 배터리 데이터셋의 사이클 중, 'discharge' 사이클의 인덱스를 뽑아내자
% j는 몇 번째 'discharge'인가를 나타내고, i는 사이클의 index number를 가리킴
for i = 1 : len
    if data.cycle(:, i).type == "discharge"
        j = j + 1;
        data_idx(j) = i;
    end
end

% 각 사이클에서, 시작점으로부터 10개의 데이터만 살펴보고
% 급격히 데이터 값이 변하는 시점을 추출하자(내부 저항에 의한 급격한 전압 강하가 발생하는 시점)
len_data  = length(data_idx);
time_idx  = 9;
pseudo_1  = zeros(len_data,2);
for cycle = 1:len_data
    for time = 1 : time_idx
        a = data.cycle(data_idx(cycle)).data.Voltage_measured(1, time+1);
        b = data.cycle(data_idx(cycle)).data.Voltage_measured(1, time);
    
        if b-a > 0.05
            pseudo_1(cycle,:) =  [time time+1];
        end
    end
end

% V = IR -> R = V/I 이므로, R_meas = dV/dI를 구해보자.
Feature_Rmeas = zeros(len_data,1);
for cycle = 1:len_data
    volt_bf = data.cycle(data_idx(cycle)).data.Voltage_measured(1,pseudo_1(1,1));
    volt_af = data.cycle(data_idx(cycle)).data.Voltage_measured(1,pseudo_1(1,2));
    
    curr_bf = data.cycle(data_idx(cycle)).data.Current_measured(1,pseudo_1(1,1));
    curr_af = data.cycle(data_idx(cycle)).data.Current_measured(1,pseudo_1(1,2));
    
    Feature_Rmeas(cycle,1) = (volt_af-volt_bf) / (curr_af - curr_bf);
end

end
