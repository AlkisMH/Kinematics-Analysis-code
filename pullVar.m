function [fs,trialNum,tp,st,et,rotn,rxnTime,trialEnd,resultString,timeStamp] = pullVar(varIn)

fs=1000;
trialNum = varIn.TRIAL.TRIAL_NUM;
tp = varIn.TRIAL.TP;
st = varIn.TP_TABLE.Start_Target(tp,1);
et = varIn.TP_TABLE.End_Target(tp,1);
rotn = varIn.TP_TABLE.Rotation(tp,1);
rxnTime = varIn.EVENTS.TIMES(2)*fs;
trialEnd = varIn.EVENTS.TIMES(3)*fs;

resultString = varIn.EVENTS.LABELS(1,3);
timeStamp = varIn.TRIAL.TIME;




