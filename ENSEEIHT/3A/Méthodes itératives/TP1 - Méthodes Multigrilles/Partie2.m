format long e;
clear all;
%% =========================[direct metod]=================================

% Setup maillage
N = 64;
h = 1/N;
% Setup Jacobi
omega = 2/3;
% Setup of the fine grid matrix
% and the right-hand side
Ah = getMatrix(N);
rhsf = 2*ones(N-1,1);
% Compute direct solution of linear system
sol_ref = Ah\rhsf;

%% =======================[multi grid method]==============================

% Setup of the coarse grid matrix
A2h = getMatrix(N/2);
% Setup interpolation matrix
I2hh = interpol(N);
Ih2h = restriction(N);
% Initial vector
v(1:N-1,1) = 0;
% Stopping criterion: relative error below tolerance or max iterations
max_iter = 5;
tol = 1e-10;
err = zeros(max_iter,1);
i = 0;
err_current = 2*tol;
% Multigrid iterations with 2 pre-smoothing steps
while (i < max_iter) && (err_current > tol)
    i = i + 1;
    v = weighted_jacobi(Ah,v,rhsf,omega,2);
    % residual on fine grid
    res_h = rhsf - Ah*v;
    % Restriction of residual to coarser grid
    res_2h = Ih2h*res_h;
    % Solve the coarse grid error equation
    e_2h = A2h\res_2h;
    % Interpolate the coarse grid error to the fine grid
    e_h = I2hh*e_2h;
    % Update the approximate fine grid solution
    v = v + e_h;
    % Compute the relative error with respect to the direct solution
    err_current = norm(sol_ref-v);
    err(i) = err_current;
end
% Trim error history to actual number of iterations
err = err(1:i);

disp(['Inverse error in ' num2str(i) ' iterations:']);
disp(err);