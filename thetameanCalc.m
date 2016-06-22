function [thetaMean,thetaVec_old] = thetameanCalc(rTheta,trialNum,thetaVec_old)

thetaMean = mean(thetaVec_old);
thetaVec = thetaVec_old;

if trialNum <= 10
        thetaVec(trialNum) = rTheta;        
     else
        thetaVec(1:9) = thetaVec_old(2:10);
        thetaVec(10) = rTheta;
end %if statement
    
    thetaVec_old = thetaVec;