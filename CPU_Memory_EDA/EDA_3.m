clear all;
close all;

id={'A', 'B', 'C', 'D', 'E', 'F'};

CPU_max=cell(1, 6);
CPU_min=cell(1, 6);
CPU_avg=cell(1, 6);
CPU_first=cell(1, 6);
CPU_last=cell(1, 6);
CPU_count=cell(1, 6);
CPU_std=cell(1, 6);
Memory_max=cell(1, 6);
Memory_min=cell(1, 6);
Memory_avg=cell(1, 6);
Memory_first=cell(1, 6);
Memory_last=cell(1, 6);
Memory_count=cell(1, 6);
Memory_std=cell(1, 6);

% per hours ans mins to get data
hours=3;
mins=0;

for k=1:6
    [CPU, CPU_date, CPU_id, Memory, Memory_date, Memory_id] = EDA_4(id{k});  %read data

    % EDA CPU
    %[max_data, min_data, avg_data, first_date, last_date, i]=roll_data(date, data, hours, mins)
    CPU_max_tep=[];
    CPU_min_tep=[];
    CPU_avg_tep=[];
    CPU_first_tep=[];
    CPU_last_tep=[];
    CPU_count_tep=[];
    CPU_std_tep=[];
    
    i=1;
    while i<length(CPU_date)
        j=0;
        [max_data, min_data, avg_data, first_date, last_date, j, std_data]=roll_data(CPU_date(i:end,:), CPU(i:end,:), hours, mins);
        CPU_max_tep=[CPU_max_tep; max_data];
        CPU_min_tep=[CPU_min_tep; min_data];
        CPU_avg_tep=[CPU_avg_tep; avg_data];
        CPU_first_tep=[CPU_first_tep; first_date];
        CPU_last_tep=[CPU_last_tep; last_date];
        CPU_count_tep=[CPU_count_tep; j];
        CPU_std_tep=[CPU_std_tep; std_data];
        i=i+j;
    end

    % EDA Memory
    %[max_data, min_data, avg_data, first_date, last_date, i]=roll_data(date, data, hours, mins)
    Memory_max_tep=[];
    Memory_min_tep=[];
    Memory_avg_tep=[];
    Memory_first_tep=[];
    Memory_last_tep=[];
    Memory_count_tep=[];
    Memory_std_tep=[];
    i=1;
    while i<length(Memory_date)
        j=0;
        [max_data, min_data, avg_data, first_date, last_date, j, std_data]=roll_data(Memory_date(i:end,:), Memory(i:end,:), hours, mins);
        Memory_max_tep=[Memory_max_tep; max_data];
        Memory_min_tep=[Memory_min_tep; min_data];
        Memory_avg_tep=[Memory_avg_tep; avg_data];
        Memory_first_tep=[Memory_first_tep; first_date];
        Memory_last_tep=[Memory_last_tep; last_date];
        Memory_count_tep=[Memory_count_tep; j];
        Memory_std_tep=[Memory_std_tep; std_data];
        i=i+j;
    end
    
    CPU_max{k}=CPU_max_tep;
    CPU_min{k}=CPU_min_tep;
    CPU_avg{k}=CPU_avg_tep;
    CPU_first{k}=CPU_first_tep;
    CPU_last{k}=CPU_last_tep;
    CPU_count{k}=CPU_count_tep;
    CPU_std{k}=CPU_std_tep;
    Memory_max{k}=Memory_max_tep;
    Memory_min{k}=Memory_min_tep;
    Memory_avg{k}=Memory_avg_tep;
    Memory_first{k}=Memory_first_tep;
    Memory_last{k}=Memory_last_tep;
    Memory_count{k}=Memory_count_tep;
    Memory_std{k}=Memory_std_tep;
    clearvars -except 'id' 'CPU_max' 'CPU_min' 'CPU_avg' 'CPU_first' 'CPU_last' 'CPU_count' 'CPU_std' 'Memory_max' 'Memory_min' 'Memory_avg' 'Memory_first' 'Memory_last' 'Memory_count' 'Memory_std' 'hours' 'mins' 
end

% filename = 'EDA_FFF.xlsx';
% A=[CPU_max, CPU_min, CPU_avg, Memory_max, Memory_min, Memory_avg];
% xlswrite(filename,A);

%figure('Color','White'); set(f, 'Position', [0 0 1500 600])
subplot(2,2,1), plotyy(1:length(CPU_max(:,1)), CPU_max(:,1), 1:length(CPU_max(:,2)), CPU_max(:,2));
title('CPU Max');legend('GHz', 'usage(%)'); 
subplot(2,2,2), plotyy(1:length(CPU_min(:,1)), CPU_min(:,1),1:length(CPU_min(:,2)), CPU_min(:,2));
title('CPU Min'); legend('GHz', 'usage(%)'); 
subplot(2,2,3), plot(1:length(Memory_max(:,1)), Memory_max(:,1));
title('Memory Max'); legend('usage(%)'); 
subplot(2,2,4), plot(1:length(Memory_min(:,1)), Memory_min(:,1));
title('Memory Min'); legend('usage(%)');  

%figure('Color','White'); set(f, 'Position', [0 0 1500 600])
subplot(2,2,1), plotyy(1:length(CPU_avg(:,1)), CPU_avg(:,1), 1:length(CPU_avg(:,2)), CPU_avg(:,2));
title('CPU Average');legend('GHz', 'usage(%)'); 
subplot(2,2,2), plot(1:length(Memory_avg(:,1)), Memory_avg(:,1));
title('Memory Average'); legend('usage(%)'); 
subplot(2,2,3), plotyy(1:length(CPU_std(:,1)), CPU_std(:,1), 1:length(CPU_avg(:,2)), CPU_std(:,2));
title('CPU STD');legend('GHz', 'usage(%)'); 
subplot(2,2,4), plot(1:length(Memory_std(:,1)), Memory_std(:,1));
title('Memory STD'); legend('usage(%)'); 