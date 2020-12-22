function [ordere] = DiagDom(A)
n = length(A);
sz = factorial(n);
Ae = A;
mx = IsDiagDom(Ae);
order = 1 : n;
ordere = order;
r = perms (order);
for i = 1 : sz
    if mx == n
        break;
    end
    Ae = A(r(i, :), :);
    dom = IsDiagDom(Ae);
    if (dom > mx)
        ordere = r(i, :);
        mx = dom;
    end
end
