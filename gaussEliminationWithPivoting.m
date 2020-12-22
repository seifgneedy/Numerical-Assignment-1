function x = gaussEliminationWithPivoting(A,B,percision)

format shortg
%A0 is the Augmented Matrix
A0 = [A B];
n=length(A);

%pivoting Matrix A0
for i=1:n-1
    for j=i+1:n
        if abs(A(j,i)) > abs(A(i,i))
            %switching Rows
            sw = A(j,:);  B2 = B(j);
            A(j,:) = A(i,:); B(j) = B(i);
            A(i,:) = sw; B(i) = B2;
        end
    end
end

%building upper triangular matrix after the matrix was pivoted
s = 0;
for j=1:n-1
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
