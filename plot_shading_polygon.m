function plot_shading_polygon(x,y,color)

d = size(y);
ymean = nanmean(y,2);
%note that the line below takes missing values into account and
%appropriately adjusts the sqrt(n) at each datapoint to calculate the
%standard error
yerr = nanstd(y,0,2)./sqrt(sum(~isnan(y),2));
fill([x wrev(x)]',[ymean-yerr; wrev(ymean+yerr)],color,'EdgeColor',color);