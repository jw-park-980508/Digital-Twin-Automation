Ball_07 = statical_data(X118_DE_time,X282_FE_time,"Ball_07");
Ball_14 = statical_data(X185_DE_time,X286_FE_time,"Ball_14");
Ball_21 = statical_data(X222_DE_time,X290_FE_time,"Ball_21");

IR_07 = statical_data(X105_DE_time,X278_FE_time,"Inner_07");
IR_14 = statical_data(X169_DE_time,X274_FE_time,"Inner_14");
IR_21 = statical_data(X209_DE_time,X270_FE_time,"Inner_21");

OR_07 = statical_data(X130_DE_time,X294_FE_time,"Outer_07");
OR_14 = statical_data(X197_DE_time,X313_FE_time,"Outer_14");
OR_21 = statical_data(X234_DE_time,X315_FE_time,"Outer_21");

Norm = statical_data(X097_DE_time,X097_FE_time,"Normal");

stat_table = [Ball_07 ; Ball_14; Ball_21; IR_07; IR_14; IR_21; OR_07; OR_14; OR_21; Norm]