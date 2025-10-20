% Script to run the V-cycle
clear all;
% Setup grid
N = 32;
h = 1/N;
% Jacobi weighting parameter
omega = 2/3;
% System matrix
Ah = getMatrix(N);
% Initial guess
v = zeros(N-1,1);
% Evaluate the solution at each mesh point
xi=h:h:1-h; xi = xi'; % row vector to column vector
usol = xi.^2 .* (1 - xi).^2; % exact solution for -u'' = f with u(0)=u(1)=0
rhsf= -2 + 12*xi - 12*xi.^2;
% Number of V-cycles
maxit = 10;
% Initialize errors variable and compute initial errors
res = zeros(maxit+1,1);
errorL2 = zeros(maxit+1,1);
% Initial residual and L2 error
res(1) = norm(rhsf - Ah*v);
errorL2(1) = compute_L2_error(N, usol, v);
nu1=1;
nu2=1;
for i=1:maxit
    v = V_Cycle(Ah,rhsf,v,omega,nu1,nu2,N);
    % Compute errors after each iteration
    errorL2(i+1) = compute_L2_error(N, usol, v);
    res(i+1) = norm(rhsf - Ah*v);
end