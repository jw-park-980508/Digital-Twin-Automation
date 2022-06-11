%% 데이터는 de fe 같이 들어옴
function hamonic = envelop_data(x1,x2,kind,kind2)

t_table_temp=[];

N = 120000;
index = N/15;
fs = 12000;
fault_frequency();
hamonic_temp = zeros(1,6);
num = ["1st" " 2nd" " 3th" " 4th" " 5th" " 6th"];
var = zeros(6,6);
var = [kind2+"Inner_DE_"+num; kind2+"Outer_DE_"+num ; kind2+"FSB_DE_"+num; ...
        kind2+"Inner_FE_"+num ;kind2+"Outer_FE_"+num;  kind2+"FSB_FE_"+num]; 

t_table = table;

for i = 1:15
        [x1_pEnv, x1_fEnv, ~, ~ ] = envspectrum(x1((i-1)*index + 1 : i*index),fs);
        [x2_pEnv, x2_fEnv, ~, ~ ] = envspectrum(x2((i-1)*index + 1 : i*index),fs);

    temp = [x1_pEnv x1_fEnv x2_pEnv x2_fEnv];
    %var = ["x1_pEnv", "x1_fEnv", "x2_pEnv",  "x2_fEnv"];
    %envelop = array2table(temp, 'VariableNames', var);
    envelop = temp;
    for j = 1:6
        BPFI_DE_idx = find(envelop(:,2) > j*0.99*FBPI_DE & envelop(:,2) < j*1.01*FBPI_DE);
        BPFI_FE_idx = find(envelop(:,4) > j*0.99*FBPI_FE & envelop(:,4) < j*1.01*FBPI_FE);    
        BPFO_DE_idx = find(envelop(:,2) > j*0.99*FBPO_DE & envelop(:,2) < j*1.01*FBPO_DE);
        BPFO_FE_idx = find(envelop(:,4) > j*0.99*FBPO_FE & envelop(:,4) < j*1.01*FBPO_FE);
        FSB_DE_idx = find(envelop(:,2) > j*0.99*FSB_DE & envelop(:,2) < j*1.01*FSB_DE);
        FSB_FE_idx = find(envelop(:,4) > j*0.99*FSB_FE & envelop(:,4) < j*1.01*FSB_FE);      
        
        hamonic_temp(1,:) = [rms(envelop(BPFI_DE_idx,1)) rms(envelop(BPFO_DE_idx,1)) rms(envelop(FSB_DE_idx,1)) ...
                        rms(envelop(BPFI_FE_idx,3)) rms(envelop(BPFO_FE_idx,3)) rms(envelop(FSB_FE_idx,3))];

        ev_table = array2table(hamonic_temp,'VariableNames', var(:,j) );
        
        t_table_temp = [t_table_temp ev_table];
    end
    
    t_table = [t_table ; t_table_temp];
    t_table_temp = [];
    
end

    Class_array = string(zeros(15,1));
    Class_array(:,1) = kind;
    Class_table = array2table(Class_array,'VariableNames', "Class");
    
    hamonic = [t_table Class_table];
    
end


    
