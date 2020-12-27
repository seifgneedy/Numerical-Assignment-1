function [dom] = IsDiagDom( A, ASum ) 
dom = 0;
for r = 1:size(A,1)
    rowdom = 2 * abs(A(r,r)) >= ASum(r);
    dom = dom + rowdom;
end
end