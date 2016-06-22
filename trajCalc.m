function [hxy_offset,etxy_offset] = trajCalc(data,st,et,trialEnd,pareticArm,parFlag)

STX = data.TARGET_TABLE.X_GLOBAL(st,1)*0.01;
STY = data.TARGET_TABLE.Y_GLOBAL(st,1)*0.01;
ETX = data.TARGET_TABLE.X_GLOBAL(et,1)*0.01;
ETY = data.TARGET_TABLE.Y_GLOBAL(et,1)*0.01;

if strcmp(pareticArm,'Right') && parFlag ==1
    HX = data.Right_HandX(1:trialEnd); 
    HY = data.Right_HandY(1:trialEnd);
elseif strcmp(pareticArm,'Right') && parFlag ==0
    HX = data.Left_HandX(1:trialEnd); 
    HY = data.Left_HandY(1:trialEnd);
elseif strcmp(pareticArm,'Left') && parFlag ==1
    HX = data.Left_HandX(1:trialEnd); 
    HY = data.Left_HandY(1:trialEnd);
elseif strcmp(pareticArm,'Left') && parFlag == 0
    HX = data.Right_HandX(1:trialEnd); 
    HY = data.Right_HandY(1:trialEnd);
else
    msg='Error: Cannot determine correct arm data to analyze';
end

hxy_offset = [HX-STX, HY-STY];
etxy_offset = [ETX-STX, ETY-STY];




