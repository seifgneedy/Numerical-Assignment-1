function x = doolittleLU(a, b, n, x)
    o = 1 : n;
    s = ones(1, n);
    er = 0;
    [a, o, er] = decompose(a, n, o, s, er);
    if(er == -1)
        % what happens if can't be solved
        %
        %
        %
        %
    else
        x = substitute(a, o, n, b, x);
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
        o = pivot(a, o, s, n, k);
        if(~isfinite(abs(a(o(k),k)) / s(o(k))))
            er = -1;
            return;
        end
        for r = k+1 : n
            a(o(r), k) = a(o(r), k) / a(o(k), k);
            for c = k+1 : n
                a(o(r), c) = a(o(r), c) - a(o(r), k) * a(o(k), c);
            end
        end
    end
    if( ~isfinite(abs(a(o(n),n)) / s(o(n))) )
        er = -1;
     end
end
function o = pivot(a, o, s, n, k)
    p = k;
    big = abs( a(o(k),k) / s(o(k)) );
    for i = k+1 : n
        dummy = abs(a(o(i),k) / s(o(i)));
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
function x = substitute(a, o, n, b, x)
    y = ones(1, n);
    y(o(1)) = b(o(1));
    % forward substitution
    for q = 2 : n
        sum = b(o(q));
        for p = 1 : q-1
            sum = sum - a(o(q), p) * b(o(p));
        end
        y(o(q)) = sum;
    end
    
    % backward substitution
    x(n) = y(o(n)) / a(o(n), n);
    for q = n-1 : -1 : 1
        sum = 0;
        for p = q+1 : n
            sum = sum + a(o(q), p) * x(p);
        end
        x(q) = (y(o(q)) - sum) / a(o(q), q);
    end
end