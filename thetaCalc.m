% Modified by Alkis, June 2016
% Output:
% theta_ideal: ideal movement direction;
% theta:       movement direction (at dt_angle (time) after movement onset)
% theta_10cm:  movement direction 10cm away (or, if movement is shorter,
%              the angle at the furtherst point provided that it is at least 5cm away
% theta_vmax: movement direction at peak speed point
% theta_end: movement direction at the end of movement

function [theta_ideal,theta,theta_10cm,theta_vmax,theta_end] = thetaCalc(hxy_offset,etxy_offset,et)

%Ideal angle
[etTheta1,~] = cart2pol(etxy_offset(1),etxy_offset(2));
theta_ideal = etTheta1 * 180/pi;

%To calculate movement onset, peak speed etc. first smooth the data as in SMARTS

%Low-pass filter the data
Fs = 1000; %check this
Wn = 8;
Ws = Fs/2;
[b,a] = butter(8,Wn/Ws,'low');

filt_data = filtfilt(b,a,hxy_offset);
x = filt_data(:,1);
y = filt_data(:,2);

dt = 1/Fs; %change this if I get exact timestamps

%Calculate velocity, in m/s
vel = sqrt(diff(x).^2+diff(y).^2)./dt;
acc = [0; diff(vel)]./dt;
jrk = [0; diff(acc)]./dt;

%Find t_onset and t_end

%First, find time of peak velocity. Note that, sometimes the file contains
%part of a different movement than the main one. So, in addition to JC's
%criterion, I will exclude timepoints where the hand is still moving (>0.02
%m/s) at the beginning of the file
i_waiting = find(vel<0.02,1,'first');
i = i_waiting - 1 + find (vel(i_waiting:end)>0.1,1,'first');
i_vmax = i - 1 + find(acc(i:end-1).*acc(i+1:end)<0,1,'first');

%Now, scan bacwards from i_vmax to find the point where the velocity
%crosses 0.02 m/s
i_onset = find(vel(1:i_vmax)<0.02,1,'last');

if ~isempty(i_onset)
    
    %For t_end, find the first time after t_vmax where velocity drops below
    %0.02 m/s for at least 0.1 seconds
    n_stop = round(0.1/dt);
    q_conv = conv(single(vel(i_vmax:end)<0.02),[ones(n_stop,1); zeros(n_stop,1)],'same');
    i_end = i_vmax + find(q_conv == n_stop,1,'first');
    %Reconsider this solution
    if isempty(i_end), i_end = length(vel); end
    
    %Angular deviation
    dt_angle = 0.150;
    i_angle = i_onset+round(dt_angle/dt);
    
    %Distance traveled
    distance_away = sqrt(x.^2 + y.^2);
    i_10cm = find(distance_away>0.095,1,'first'); %10cm - target radius??
    if isempty(i_10cm)&&max(distance_away)>0.05
        i_10cm = find(distance_away==max(distance_away),1,'first');
    end
    
    %Note: the start circle is at (0,0)
    theta = atan2d(y(i_angle)-0,x(i_angle)-0);
    theta_vmax = atan2d(y(i_vmax)-0,x(i_vmax)-0);
    theta_10cm = atan2d(y(i_10cm)-0,x(i_10cm)-0);
    theta_end = atan2d(y(i_end)-0,x(i_end)-0);
    
    if isempty(i_10cm), theta_10cm = NaN; end
    
    %Total distance traveled after movement onset
    dist_trav = cumsum(sqrt(diff(x(i_onset:i_end)).^2+diff(y(i_onset:i_end)).^2));
    ideal_dist = sqrt((etxy_offset(1) - x(i_onset))^2 + (etxy_offset(2) - y(i_onset))^2);
    dist_ratio = dist_trav(end)/ideal_dist;
    
    %Jerk
    mvt_jerk = 0.5*sum(jrk(i_onset:i_end).^2);
    
    %Movement time
    total_mvt_time = (i_end-i_onset)*dt;
    acc_time = (i_vmax-i_onset)*dt;
    dec_time = (i_end-i_vmax)*dt;
else
    good = 0;
    %Will update this
    [i_onset,i_vmax,i_end,i_angle,i_10cm,...
        theta,theta_vmax,theta_10cm,theta_end,theta_ideal,...
        dist_trav,ideal_dist,dist_ratio,...
        total_mvt_time,acc_time,dec_time,mvt_jerk] = deal(NaN);
end