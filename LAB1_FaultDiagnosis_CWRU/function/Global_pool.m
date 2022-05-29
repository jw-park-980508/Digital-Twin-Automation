stat_table_temp = stat_table;
wp_table_temp = wp_table;

stat_table_temp(:,27) = [];
wp_table_temp(:,33) = [];

global_pool = [stat_table_temp wp_table_temp env_table]