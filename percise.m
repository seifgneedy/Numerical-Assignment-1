function [B] = percise(A, precision)
format shortg
n = size(A);
B = A;
for i = 1 : n(1)
    for j = 1 : n(2)
        B(i, j) = round(A(i, j), precision, 'significant');
    end
end