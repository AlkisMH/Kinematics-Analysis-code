function [res]=findResult(resultString)

if strncmp('MISS',resultString,4)
    res = 0;
else
    res = 1;
end