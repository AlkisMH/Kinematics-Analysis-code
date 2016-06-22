%function [Y,n,z] = clean_outlier_IQR(X,N) performs iqr-based outlier
%rejection, removing points in vector X that are N iqr away from the median
%and replacing them witn NaNs. The "cleaned-up" result is Y.
%Also returned is the number of rejected points, n, as well as a vector z
%which indicates how many times away from the median each point of X is.
%That is, X points with a corresponding value greater than N are the ones
%replaced with NaNs in Y.
%
%Alkis / Maurice, revised February 2014

function [Y,n,z] = clean_outlier_IQR(X,N)

IQR = iqr(X);
med_ = nanmedian(X);

Y = X;
z = (X-med_)/IQR;
i = abs(z)>N;
Y(i) = NaN;
n = sum(i);
