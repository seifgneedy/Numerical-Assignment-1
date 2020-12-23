function b = isPositiveDifiniteMatrix(a)
    [~, n] = size(a);
    values = eig(a);
    b = 1;
    for i=1:n
        if(values(i) <= 0)
            b = 0;
            return;
        end
    end
end

