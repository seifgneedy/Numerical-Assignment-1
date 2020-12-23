function x = croutLU(a, b, precision)
    [~, n] = size(a);
    a = round(a,precision,'significant');
    x = ones(n, 1);
    o = 1 : n;
    s = ones(n, 1);
    er = 0;
    [a, o, er] = decompose(a, n, o, s, er, precision);
    if(er == -1)
        % can't be solved
        x = -1;
        return;
    else
        [x, er] = substitute(a, o, n, b, x, er, precision);
        if(er == -1)
            x = -1;
            return;
        end
    end
end
function [a, o, er] = decompose(a, n, o, s, er, precision)
    %finding scales
    for h = 1 : n
        s(h) = abs(a(h, 1));
        for w = 2 : n
            if(s(h) < abs(a(h, w)))
                s(h) = abs(a(h, w));
            end
        end
    end
    o = pivot(a, o, s, n, 1, precision);
    if(~isfinite(abs(a(o(1),1)) / s(o(1))))
        er = -1;
        return;
    end
    for j = 2 : n
        a(o(1), j) = round(a(o(1), j) / a(o(1), 1),precision,'significant');
        if(~isfinite(a(o(1), j)))
            er = -1;
            return;
        end
    end
    for i = 2 : n
        for j = 2 : n
            if( j <= i)
                % Lij
                for k = 1 : j-1
                    a(o(i), j) = a(o(i), j) - round(a(o(i), k) * a(o(k), j),precision,'significant');
                    a(o(i), j) = round(a(o(i), j),precision,'significant');
                end
            else
                a(o(i), j) = (a(o(i), j) - round(a(o(i), 1:o(i) - 1) * a(1:o(i) - 1, j),precision,'significant')) / a(o(i), i);
                a(o(i), j) = round(a(o(i), j),precision,'significant');
            end
        end
    end
end
function o =  pivot(a, o, s, n, k, precision)
    p = k;
    big = abs( round(a(o(k),k) / s(o(k)),precision,'significant') );
    for i = k+1 : n
        dummy = abs(round(a(o(i),k) / s(o(i)),precision,'significant'));
        if(dummy > big)
            big = dummy;
            p = i;
        end
    end
    % swapping the rows indeces
    dummy = o(p);
    o(p) = o(k);
    o(k) = dummy;
end
function [x, er] = substitute(a, o, n, b, x, er, precision)
    y = ones(n, 1);
    y(o(1)) = b(o(1)) / a(o(1), 1);
    if( ~isfinite(y(o(1))) )
        er = -1;
        return;
    end
    % forward substitution
    for i = 2 : n
        sum = 0;
        for j = 1 : i-1
            sum = sum + round(a(o(i), j) * y(o(j)),precision,'significant');
            sum = round(sum,precision,'significant');
        end
        y(o(i)) = round((b(o(i)) - sum),precision,'significant')/ a(o(i), i);
        y(o(i)) = round(y(o(i)),precision,'significant');
        if( ~isfinite(y(o(i))) )
            er = -1;
            return;
        end
    end
    % backward substitution
    x(n) = y(o(n));
    for i = n-1 : -1 : 1
        sum = y(o(i));
        for j = i+1 : n
            sum = sum - round(a(o(i), j) * x(j),precision,'significant');
            sum = round(sum,precision,'significant');
        end
        x(i) = sum;
    end
end