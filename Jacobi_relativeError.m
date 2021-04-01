function [y, converge] = Jacobi_relativeError(A, b, x, error, precision)

A = percise(A, precision);
b = percise(b, precision);
x = percise(x, precision);

error = abs(error);

prevnormVal=Inf; 
converge = true;
numberdiverge = 0;

order = DiagDom(A);
A = A(order, :);
b = b(order, :);

format shortg
n=length(x);

while (1 == 1)
    x_old=x;
    for i = 1 : n
        sigma=0;
        for j = 1 : n
            if j~=i
                sigma=sigma+A(i,j)*x_old(j);
                sigma = round(sigma, precision, 'significant');
            end
        end
        z = round(1/A(i,i), precision, 'significant');
        x(i) = z * (b(i)-sigma);
        x(i) = round(x(i), precision, 'significant');
    end
    
    flag = true;
    for i = 1 : n
        if abs((x(i) - x_old(i)) / x(i)) * 100 > error
            flag = false;
            break;
        end
    end
    if flag
        break;
    end
    
    normVal=abs(x_old-x);
    if prevnormVal < normVal
        numberdiverge = numberdiverge + 1;
    else
        numberdiverge = 0;
    end
    prevnormVal = normVal;
    if numberdiverge >= 5
        converge = false;
        break;
    end
    
end
y = x;