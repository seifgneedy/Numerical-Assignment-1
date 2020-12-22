function x = gaussJordan(A0,B,percision)
format shortg
%A is the Augmented Matrix
A = [A0 B];
n=length(A0);

%Making Triangularize form from A
for k = 1: n-1
    %checking if the pivot is zero
    if A(k,k) == 0
        s = k;
        for s = s+1 : n
            if A(s,k) == 0
                continue
            end
            break
        end
        %swapping the rows
        A2 = A(k,:); B2 = B(k);
        A(k,:) = A(s,:); B(k) = B(s);
        A(s,:) = A2; B(s) = B2;
    end
    
    for i = k+1: n
        m = A(i,k) / A(k,k);
        for j = k : n+1
            A(i,j) = A(i,j) - m*A(k,j);
        end
    end
end
disp('Traingular Augmented Matrix is :');
disp(A);


%Getting Answers
X(n) = A(n,n+1) / A(n,n);
for j = n-1 : -1 : 1
    sum = 0;
    for i=1 : n-j
        sum = sum + A(j,n+1-i) * X(n+1-i);
    end
    X(j) = (A(j,n+1) - sum) / A(j,j);
    X(j) = round(X(j), percision,'significant');
end

%check if its NaN or infinity
if isnan(X(1,1)) == 1
    x = 1;
end
if isinf(X(1,1)) == 1
    x = 2;
end
if ((isnan(X(1,1)) ~= 1) &&(isinf(X(1,1)) ~= 1 ))
    x = X;
end