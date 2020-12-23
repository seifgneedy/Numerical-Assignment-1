function x = doolittleLU(a, b, precision)
    [~, n] = size(a(1,:));
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
        x = substitute(a, o, n, b, x, precision);
    end
end
function [a, o, er] = decompose(a, n, o, s, er)
    %finding scales
    for h = 1 : n
        s(h) = abs(a(h, 1));
        for w = 2 : n
            if(s(h) < abs(a(h, w)))
                s(h) = abs(a(h, w));
            end
        end
    end
    for k = 1 : n-1
        o = pivot(a, o, s, n, k, precision);
        if(~isfinite(abs(a(o(k),k)) / s(o(k))))
            er = -1;
            return;
        end
        for r = k+1 : n
            a(o(r), k) = round(a(o(r), k) / a(o(k), k),precision,'significant');
            for c = k+1 : n
                a(o(r), c) = a(o(r), c) - round((a(o(r), k) * a(o(k), c)),precision,'significant');
                a(o(r), c) = round(a(o(r), c),precision,'significant');
            end
        end
    end
    if( ~isfinite(abs(a(o(n),n)) / s(o(n))) )
        er = -1;
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
function x = substitute(a, o, n, b, x, precision)
    y = ones(n, 1);
    y(o(1)) = b(o(1));
    % forward substitution
    for q = 2 : n
        sum = b(o(q));
        for p = 1 : q-1
            sum = sum - round(a(o(q), p) * y(o(p)),precision,'significant');
            sum = round(sum,precision,'significant');
        end
        y(o(q)) = sum;
    end
    
    % backward substitution
    x(n) = y(o(n)) / a(o(n), n);
    for q = n-1 : -1 : 1
        sum = 0;
        for p = q+1 : n
            sum = sum + round(a(o(q), p) * x(p),precision,'significant');
            sum = round(sum,precision,'significant');
        end
        x(q) = round((y(o(q)) - sum) / a(o(q), q),precision,'significant');
    end
end