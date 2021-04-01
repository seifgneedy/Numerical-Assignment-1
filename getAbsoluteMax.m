function [absoluteMax] = getAbsoluteMax(A, ASum)
absoluteMax = 0;
n = length(A);
for i = 1 : n
    if 2 * abs(max(abs(A(i,:)))) >= ASum(i)
        absoluteMax = absoluteMax + 1;
    end
end