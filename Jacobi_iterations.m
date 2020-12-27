function [y, converge] = Jacobi_iterations(A, b, x, iterations, precision)

A = percise(A, precision);
b = percise(b, precision);
x = percise(x, precision);

format shortg
n=length(x);

prevnormVal=Inf; 
converge = true;
numberdiverge = 0;

order = DiagDom(A);
A = A(order, :);
b = b(order, :);

for k = 1 : iterations
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
    
    normVal=abs(x_old-x);
    if prevnormVal < normVal
        numberdiverge = numberdiverge + 1;
    else
        numberdiverge = 0;
    end
    prevnormVal = normVal;
    if numberdiverge >= 3
        converge = false;
    end
    
end
y = x;