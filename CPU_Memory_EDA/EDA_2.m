clear all; 
close all;

%read excel data
id=['A', 'B', 'C', 'D', 'E', 'F'];
filename={'\CPU\CPU_';
          '\Memory\Memory_'};
Attached_file_name={'.xlsx'};
filepath=cell(2,6);
for i=1:6
    filepath(1,:)=strcat('H:\Google Drive NTU\NTU\Master\進階軟體開發專題\UtilizationDataLog',filename(1),id(i),Attached_file_name);
    filepath(2,:)=strcat('H:\Google Drive NTU\NTU\Master\進階軟體開發專題\UtilizationDataLog',filename(2),id(i),id(i),Attached_file_name);
end

%CPU=zeros(maxnumofcase, 5);  % id, date, GHz, usage(%), using
%memory=zeros(maxnumofcase, 4);   % id, date, using, usage(%)

%read CPU data
[CPU, CPU_A, CPU_rawdata]=xlsread(strjoin((filepath(1))));
% CPU: CPU_GHz, CPU_usage(%)
CPU_id=CPU_A(2:end,1);          % []
tep_date=CPU_A(2:end,2);         
CPU_date=cut_date(tep_date);    % [year, mounth, day, hour, min, sec]
clearvars 'tep_date'

%read Memory data
[Memory, Memory_A, Memory_rawdata]=xlsread(strjoin((filepath(2))));
% Memory: Memory_using(KB), Memory_usage(%)
Memory_id=Memory_A(2:end,1);         %cell2mat(Memory_A(:,1));
tep_date=Memory_A(2:end,2);          
Memory_date=cut_date(tep_date);     %% [year, mounth, day, hour, min, sec]
clearvars 'tep_date'

clearvars -except 'CPU' 'CPU_date' 'CPU_id' 'Memory' 'Memory_date' 'Memory_id'