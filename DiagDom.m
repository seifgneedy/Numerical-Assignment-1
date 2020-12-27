function [ordere] = DiagDom(A)
n = length(A);
ASum = zeros(n, 1);
for i = 1 : n
    ASum(i) = sum(abs(A(i, :)));
end
absolutemax = getAbsoluteMax(A, ASum);
sz = factorial(n);
Ae = A;
ASume = ASum;
mx = IsDiagDom(Ae, ASume);
order = 1 : n;
ordere = order;
r = perms (order);
for i = 1 : sz
    if mx == n || mx == absolutemax
        break;
    end
    Ae = A(r(i, :), :); ASume = ASum(r(i, :), :);
    dom = IsDiagDom(Ae, ASume);
    if (dom > mx)
        ordere = r(i, :);
        mx = dom;
    end
end
