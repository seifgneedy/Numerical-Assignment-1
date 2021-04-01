function [ b ] = isSymmetric( a )
    [n,~] = size(a);
    b = 1;
    for i = 1:n
        for j = 1:i
            if(a(i,j) ~= a(j,i))
                b = 0;
                return;
            end
        end
    end     
end