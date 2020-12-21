function x = gaussElimination(A,B,percision)
format shortg
n = length(A);
%building upper triangular matrix
s = 0;
for j=1:n-1
    
    %checking if the pivot is zero
    if A(j,j) == 0
        k = j;
        for k = k+1 : n
            if A(k,j) == 0
                continue
            end
            break
        end
    %swapping the rows
    A2 = A(j,:); B2 = B(j);
    A(j,:) = A(k,:); B(j) = B(k);
    A(k,:) = A2; B(k) = B2;
    end
    
    %forward elimination
    for i = 1+s : n-1
        M=A(i+1,j)/A(j,j);
        A(i+1,:) = A(i+1,:) - M*A(j,:);
        B(i+1) = B(i+1) - M*B(j);
    end
    s = s+1;
end

%backward substitution
X = zeros(n,1);
X(n)= B(n) / A(n,n);
for i = n:-1:1
    Sum=0;
    for j = i+1 : n 
        Sum = Sum + A(i,j)* X(j);
    end
    X(i) =  (B(i) - Sum) / A(i,i);
    X(i) = round(X(i), percision,'significant');
end

%check if its NaN
if isnan(X(1,1)) == 1
   x = 1;
end
if isinf(X(1,1)) == 1
   x = 2;
end
if ((isnan(X(1,1)) ~= 1) &&(isinf(X(1,1)) ~= 1 ))
   x = X;
end


    
    
    