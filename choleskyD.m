function x = choleskyD(a, b, precision)
    [~, n] = size(a);
    a = round(a,precision,'significant');
    x = ones(n, 1);
    for i = 1 : n
        for j = 1 : i
            sum = 0;
            if (j == i)
                for k = 1 :j - 1
                    sum = sum + round(a(j,k) * a(j,k),precision,'significant');
                    sum = round(sum,precision,'significant');
                end
                a(j,j) = round(sqrt(a(j,j) - sum),precision,'significant');
            else
                for k = 1 : j-1
                    sum = sum + round(a(i,k) * a(j,k),precision,'significant');
                    sum = round(sum,precision,'significant');
                end
                a(i,j) = round((a(i,j) - sum),precision,'significant') / a(j,j);
                a(i,j) = round(a(i,j),precision,'significant');
            end
        end
    end
    for i = 1:n
        if(a(i,i) == 0)
            x = -1;
            return;
        end
    end
    for i = 1:n
        for j = i+1:n
            a(i, j) = a(j , i);
        end
    end
    y = ones(n, 1);
    % forward substitution
    y(1) = b(1) / a(1, 1);
    for i = 2 : n
        sum = 0;
        for j = 1 : i-1
            sum = sum + round(a(i, j) * y(j),precision,'significant');
            sum = round(sum,precision,'significant');
        end
        y(i) = round((b(i) - sum),precision,'significant') / a(i, i);
        y(i) = round(y(i),precision,'significant');
    end
    % backward substitution
    x(n) = round(y(n) / a(n, n),precision,'significant');
    for q = n-1 : -1 : 1
        sum = 0;
        for p = q+1 : n
            sum = sum + round(a(q, p) * x(p),precision,'significant');
            sum = round(sum,precision,'significant');
        end
        x(q) = round((y(q) - sum),precision,'significant') / a(q, q);
        x(q) = round(x(q),precision,'significant');
    end
end