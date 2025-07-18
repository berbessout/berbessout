function [X_VS,w,c,code_retour] = SVM_1(X,Y)
%SVM_1 Summary of this function goes here
%   Detailed explanation goes here
eps = 1e-6;
H = [1 0 0; 0 1 0 ; 0 0 0];
f = zeros(3, 1);
A = Y.*[-X ones(size(X, 1), 1)];
B = (-1)*ones(size(X, 1), 1);
[wt, ~, code_retour] = quadprog(H, f, A, B);
c = wt(3);
w = wt(1:2);
X_VS = X(abs(A*wt - B) < eps, :);
end

