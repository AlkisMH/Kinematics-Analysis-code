function delta_theta = angdiff(theta_1,theta_2)

delta_theta = theta_1-theta_2;

i = ones(size(delta_theta));
while sum(i)
    i = delta_theta > 180; delta_theta(i) = delta_theta(i) - 360;
end

i = ones(size(delta_theta));
while sum(i)
    i = delta_theta < -180; delta_theta(i) = delta_theta(i) + 360;
end
