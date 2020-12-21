function x = croutLU(a, b, n, x)
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
        [x, er] = substitute(a, o, n, b, x, er);
        if(er == -1)
            % what happens if can't be solved
            %
            %
            %
            %
        end
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
    o = pivot(a, o, s, n, 1);
    if(~isfinite(abs(a(o(1),1)) / s(o(1))))
        er = -1;
        return;
    end
    for j = 2 : n
        a(o(1), j) = a(o(1), j) / a(o(1), 1);
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
                    a(o(i), j) = a(o(i), j) - a(o(i), k) * a(o(k), j);
                end
            else
                a(o(i), j) = (a(o(i), j) - a(o(i), 1:o(i) - 1) * a(1:o(i) - 1, j)) / a(o(i), i);
            end
        end
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
function [x, er] = substitute(a, o, n, b, x, er)
    y = ones(1, n);
    y(o(1)) = b(o(1)) / a(o(1), 1);
    if( ~isfinite(y(o(1))) )
        er = -1;
        return;
    end
    % forward substitution
    for i = 2 : n
        sum = 0;
        for j = 1 : i-1
            sum = sum + a(o(i), j) * y(o(j));
        end
        y(o(i)) = (b(o(i)) - sum) / a(o(i), i);
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
            sum = sum - a(o(i), j) * x(j);
        end
        x(i) = sum;
    end
end