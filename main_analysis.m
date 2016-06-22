clear all;clc;

% %% Subject P4
% % subjectName ='S_004P'; %name of subject folder as a string
% % pareticArm = 'Right'; %subject's paretic arm as a string
% % taskName = 'CenterOut_CLRStroke'; %name of Dex task as a string
% % blockName = 'Learn_CWRot'; %name of experiment block as a string
% % data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_004P_R01\T1\reaching data\';
% % 
% % task_list = {'CenterOut_Meret','CenterOut_UDL','CenterOut_CLRStroke','CentreOut_ExpAdapt2'};
% % block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
% %     {'UDL_NonPar_12then3','UDL_Par_3then12'},...
% %     {'Practice','Learn_CWRot','Reten'},...
% %     {'Practice','task_CC_Rot'}};
% % 
% % analyze_single_subject(subjectName,pareticArm,task_list,block_list,data_dir);
% 
% %% Subject P5
% subjectName ='S_005P'; %name of subject folder as a string
% pareticArm = 'Right'; %subject's paretic arm as a string
% taskName = 'CenterOut_CLRStroke'; %name of Dex task as a string
% blockName = 'Learn_CWRot'; %name of experiment block as a string
% data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_005P_R01\';
% 
% task_list = {'CenterOut_Meret','CenterOut_UDL','CenterOut_CLRStroke','CentreOut_ExpAdapt2'};
% block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
%     {'UDL_NonPar_12then3','UDL_Par_3then12'},...
%     {'Practice','Learn_CWRot','Reten'},...
%     {'Practice','task_CC_Rot'}};
% 
% analyze_single_subject(subjectName,pareticArm,task_list,block_list,data_dir);
% 
% %% Subject P6
% subjectName ='S_006P'; %name of subject folder as a string
% pareticArm = 'Right'; %subject's paretic arm as a string
% taskName = 'CenterOut_CLRStroke'; %name of Dex task as a string
% blockName = 'Learn_CWRot'; %name of experiment block as a string
% data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_006P_R01\T1\reaching data\';
% 
% task_list = {'CenterOut_Meret','CenterOut_UDL','CenterOut_CLRStroke','CentreOut_ExpAdapt2'};
% block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
%     {'UDL_NonPar_3then12','UDL_Par_12then3'},...
%     {'Practice','Learn_CCRot','Reten'},...
%     {'Practice'}};
% 
% analyze_single_subject(subjectName,pareticArm,task_list,block_list,data_dir);
% 
% %% Subject P7
% subjectName ='S_007P'; %name of subject folder as a string
% pareticArm = 'Right'; %subject's paretic arm as a string
% taskName = 'CenterOut_CLRStroke'; %name of Dex task as a string
% blockName = 'Learn_CWRot'; %name of experiment block as a string
% data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_007P_R01\T1\reaching data\';
% 
% task_list = {'CenterOut_Meret','CenterOut_UDL','CenterOut_CLRStroke','CentreOut_ExpAdapt2'};
% block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
%     {'UDL_NonPar_3then12','UDL_Par_12then3'},...
%     {'Practice','Learn_CCRot','Reten'},...
%     {'Practice'}};
% 
% analyze_single_subject(subjectName,pareticArm,task_list,block_list,data_dir);

%% Subject 1
subjectName ='S_001'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_001_R01\';

task_list = {'CenterOut_Meret','CenterOut_CLRStroke','CentreOut_Meret_Adap'};
task_list_T2 = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLas_VMR'};
block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
    {'Practice','Learn_CWRot','Reten'},...
    {'Initial','Adap_Paretic','Retention'}};
block_list_T2 = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CW_Rot_CLR','Left_Reten_CLR'},...
    {'Practice','Learn_CCRot','Reten'}};
num_blocks = {[1 1],[1 1 1],[1 1 1]};
num_blocks_T2 = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S001_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S001_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list_T2,block_list_T2,num_blocks_T2,data_dir,1);

%% Subject 2
subjectName ='S_002'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_002_R01\';

task_list = {'CenterOut_Meret','CenterOut_CLRStroke','CenterOut_Amanda'};
task_list_T2 = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLas_VMR'};
block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
    {'Practice','Learn_CWRot','Reten'},...
    {'Err_1T_BL1','CC_Err_1T_BL3+Rot','CC_Reten_1T'}};
block_list_T2 = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CW_Rot_CLR','Left_Reten_CLR'},...
    {'Practice','Learn_CCRot','Reten'}};
num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S002_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S002_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list_T2,block_list_T2,num_blocks,data_dir,1);

%% Subject 4
subjectName ='S_004'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_004_R01\';

task_list = {'CenterOut_Meret','CenterOut_CLRStroke','CenterOut_Amanda'};
task_list_T2 = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLas_VMR'};
block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
    {'Practice','Learn_CCRot','Reten'},...
    {'Err_1T_BL1','CW_Err_1T_BL3+Rot','CW_Reten_1T'}};
block_list_T2 = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CC_Rot_CLR','Left_Reten_CLR'},...
    {'Practice','Learn_CWRot','Reten'}};
num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S004_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S004_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list_T2,block_list_T2,num_blocks,data_dir,1);

%% Subject 5
subjectName ='S_005'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_005_R01\';

task_list = {'CenterOut_Meret','CenterOut_CLRStroke','CenterOut_Amanda'};
task_list_T2 = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLas_VMR'};
block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
    {'Practice','Learn_CWRot','Reten'},...
    {'Err_1T_BL1','CC_Err_1T_BL3+Rot','CC_Reten_1T'}};
block_list_T2 = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CW_Rot_CLR','Left_Reten_CLR'},...
    {'Practice','Learn_CCRot','Reten'}};
num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S005_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S005_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list_T2,block_list_T2,num_blocks,data_dir,1);

%% Subject 6
subjectName ='S_006'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_006_R01\';

task_list = {'CenterOut_Meret','CenterOut_CLRStroke','CenterOut_PaLaS_VMR'};
task_list_T2 = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLas_VMR'};
block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
    {'Practice','Learn_CCRot','Reten'},...
    {'Left_Practice_Err','Left_Paretic_CW_Err_Rot','Left_Reten_Err'}};
block_list_T2 = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CC_Rot_CLR','Left_Reten_CLR'},...
    {'Practice','Learn_CWRot','Reten'}};
num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S006_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S006_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list_T2,block_list_T2,num_blocks,data_dir,1);

%% Subject 7
subjectName ='S_007'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_007_R01\';

task_list = {'CenterOut_Meret','CenterOut_CLRStroke','CenterOut_Amanda'};
task_list_T2 = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLas_VMR'};
block_list = {{'SRT_Non_paretic','SRT_Paretic'},...
    {'Practice','Learn_CCRot','Reten'},...
    {'Err_1T_BL1','CW_Err_1T_BL3+Rot','CW_Reten_1T'}};
block_list_T2 = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CC_Rot_CLR','Left_Reten_CLR'},...
    {'Practice','Learn_CWRot','Reten'}};
num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S007_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S007_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list_T2,block_list_T2,num_blocks,data_dir,1);

%% Subject 9
subjectName ='S_009'; %name of subject folder as a string
pareticArm = 'Right'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_009_R01\';

task_list = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLaS_VMR'};
block_list = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Right_Practice_CLR','Right_Paretic_CW_Rot_CLR','Right_Reten_CLR'},...
    {'Right_Practice_Err','Right_Paretic_CC_Err_Rot','Right_Reten_Err'}};

num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S009_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,0);
dat_summary_S009_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list,block_list,num_blocks,data_dir,0);

%% Subject 10
subjectName ='S_010'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_010_R01\';

task_list = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLaS_VMR'};
block_list = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CC_Rot_CLR','Left_Reten_CLR'},...
    {'Left_Practice_Err','Left_Paretic_CW_Err_Rot','Left_Reten_Err'}};

num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S010_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S010_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list,block_list,num_blocks,data_dir,1);

%% Subject 11
subjectName ='S_011'; %name of subject folder as a string
pareticArm = 'Left'; %subject's paretic arm as a string
data_dir = 'C:\Users\Alkis\Documents\MATLAB\R01\data\S_011_R01\';

task_list = {'CenterOut_PaLaS','CenterOut_PaLaS_CLR','CenterOut_PaLaS_VMR'};
block_list = {{'SRT_Non_Paretic','SRT_Paretic'},...
    {'Left_Practice_CLR','Left_Paretic_CC_Rot_CLR','Left_Reten_CLR'},...
    {'Left_Practice_Err','Left_Paretic_CW_Err_Rot','Left_Reten_Err'}};

num_blocks = {[2 2],[1 1 1],[1 1 1]};
dat_summary_S011_T1 = analyze_single_subject_v2(subjectName,1,pareticArm,task_list,block_list,num_blocks,data_dir,1);
dat_summary_S011_T2 = analyze_single_subject_v2(subjectName,2,pareticArm,task_list,block_list,num_blocks,data_dir,1);
