%% ================[Discrétisation par différences finies]=================
clear all; close all;

N = 10;
A = getMatrix(N);   
rhsf = getF(N);

sol_ref = A\rhsf;
disp('Matrix A:');
disp(A);
disp('Right-hand side rhsf:');
disp(rhsf);
disp('Solution of the linear system:');
disp(sol_ref);



%% =========================[Lisseur]======================================

clear all; close all;
N = 64;
h = 1/N;
A = getMatrix(N);
omega = 2/3;
rhsf = zeros(N-1,1);
j = 1:N-1;
k = 12;

% kieme vecteur propre
um = sin(j*k/N*pi);
m = 20;
ump1 = weighted_jacobi(A,um',rhsf,omega,m);
x=h:h:1-h;
plot(x,um,x, ump1);
legend('um','ump1');
title('Damping effect of weighted Jacobi method')