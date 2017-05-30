tau = 0.005; % time step
h = 0.1; % x step
D = 1; % coeff
X = 1; % x
T = 10; % max T
n = X / h; % length horizontally
m = T / tau; % length vertically

A = ones(m+1,n+1);

for j = 1 : m+1
    A(j,1) = 100;
    A(j,n+1) = 0;
end

for i = 1 : n+1
    A(m+1,i) = 0;
end

for j = m+1 : -1 : 2
    for i = 2 : n
       A(j-1,i) = (tau * D * ( (A(j,i+1) - 2 * A(j,i) + A(j,i-1)) / h^2)) + A(j,i);
    end
end

disp(A);