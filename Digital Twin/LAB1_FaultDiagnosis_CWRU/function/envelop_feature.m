Ball_DE_07 = envelop_data(X118_DE_time,X118_FE_time,"Ball_07","DE"); Ball_DE_07(:,37) = []; %DE의 DE와 FE
Ball_FE_07 = envelop_data(X282_DE_time,X282_FE_time,"Ball_07","FE"); %DE의 DE와 FE

Ball_DE_14 = envelop_data(X185_DE_time,X185_FE_time,"Ball_14","DE"); Ball_DE_14(:,37) = [];%DE의 DE와 FE
Ball_FE_14 = envelop_data(X286_DE_time,X286_FE_time,"Ball_14","FE"); %DE의 DE와 FE

Ball_DE_21 = envelop_data(X222_DE_time,X222_FE_time,"Ball_21","DE"); Ball_DE_21(:,37) = [];%DE의 DE와 FE
Ball_FE_21 = envelop_data(X290_DE_time,X290_FE_time,"Ball_21","FE"); %DE의 DE와 FE

Inner_DE_07 = envelop_data(X105_DE_time,X105_FE_time,"Inner_07","DE"); Inner_DE_07(:,37) = [];%DE의 DE와 FE
Inner_FE_07 = envelop_data(X278_DE_time,X278_FE_time,"Inner_07","FE"); %DE의 DE와 FE

Inner_DE_14 = envelop_data(X169_DE_time,X169_FE_time,"Inner_14","DE"); Inner_DE_14(:,37) = [];%DE의 DE와 FE
Inner_FE_14 = envelop_data(X274_DE_time,X274_FE_time,"Inner_14","FE"); %DE의 DE와 FE

Inner_DE_21 = envelop_data(X209_DE_time,X209_FE_time,"Inner_21","DE"); Inner_DE_21(:,37) = [];%DE의 DE와 FE
Inner_FE_21 = envelop_data(X270_DE_time,X270_FE_time,"Inner_21","FE"); %DE의 DE와 FE

Outer_DE_07 = envelop_data(X130_DE_time,X130_FE_time,"Outer_07","DE"); Outer_DE_07(:,37) = [];%DE의 DE와 FE
Outer_FE_07 = envelop_data(X294_DE_time,X294_FE_time,"Outer_07","FE"); %DE의 DE와 FE

Outer_DE_14 = envelop_data(X197_DE_time,X197_FE_time,"Outer_14","DE"); Outer_DE_14(:,37) = [];%DE의 DE와 FE
Outer_FE_14 = envelop_data(X313_DE_time,X313_FE_time,"Outer_14","FE"); %DE의 DE와 FE

Outer_DE_21 = envelop_data(X234_DE_time,X234_FE_time,"Outer_21","DE"); Outer_DE_21(:,37) = [];%DE의 DE와 FE
Outer_FE_21 = envelop_data(X315_DE_time,X315_FE_time,"Outer_21","FE"); %DE의 DE와 FE

Normal1 = envelop_data(X097_DE_time,X097_FE_time,"Normal","DE"); Normal1(:,37) = []; % X097 = Normal1
Normal1_1 = envelop_data(X097_DE_time,X097_FE_time,"Normal","FE");   % X097 = Normal1
env_table = [Ball_DE_07 Ball_FE_07;Ball_DE_14 Ball_FE_14;Ball_DE_21 Ball_FE_21;...
             Inner_DE_07 Inner_FE_07;Inner_DE_14 Inner_FE_14;Inner_DE_21 Inner_FE_21;...
             Outer_DE_07 Outer_FE_07;Outer_DE_14 Outer_FE_14;Outer_DE_21 Outer_FE_21;...
             Normal1 Normal1_1]




