function wp_table = WaveletPacket_data(x1,x2,level, method, kind)

N = 120000;
index = N / 15;

 x1_wp = wpdec(1, level, method);
 x2_wp = wpdec(1, level, method);
 
 DE_E =  wenergy(x1_wp);
 FE_E =  wenergy(x2_wp);

 DE_table = array2table(DE_E);
 FE_table = array2table(FE_E);
 
 DE_var = DE_table.Properties.VariableNames;
 FE_var = FE_table.Properties.VariableNames;
 
 var = [DE_var FE_var];
 Class_table = table(kind,'VariableNames', "Class");

 wp_table_init = zeros(1,32);
 wp_table_temp = array2table(wp_table_init,'VariableNames', var);
 wp_table = [wp_table_temp Class_table];
 for i = 1:15
    
    x1_wpt = wpdec(x1((i-1)*index + 1 : i*index),level,method);
    x1_en = wenergy(x1_wpt);

    
    x2_wpt = wpdec(x2((i-1)*index + 1 : i*index),level,method);
    x2_en = wenergy(x2_wpt);
    
    wp_feature = [x1_en x2_en];
    Table_temp = array2table(wp_feature,'VariableNames', var );  
    Table = [Table_temp Class_table];
    wp_table = [wp_table ; Table];
end

wp_table(1,:) = [];
 

end