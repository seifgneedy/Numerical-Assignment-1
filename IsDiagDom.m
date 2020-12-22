function [dom] = IsDiagDom( A ) 
dom = 0;
for r = 1:size(A,1)
    rowdom = 2 * abs(A(r,r)) >= sum(abs(A(r,:)));
    dom = dom + rowdom;
end
end