function [X_VS,Y_VS,Alpha_VS,c,code_retour] = SVM_3(X,Y,sigma)

n = size(X,1);
eps = 1e-6;

K = zeros(n, n);
for i = 1:n
    for j = 1:n
        xi = X(i, :);
        xj = X(j, :);
        norme = (xi - xj)*(xi - xj)';
        K(i, j) = exp(-norme / (2 * sigma.^2));
    end
end

f = -ones(size(Y));
H = (Y.*Y').*K;
Aeq = Y';
Beq = 0;
lb = zeros(size(f));
[alpha,~,code_retour] = quadprog(H, f ,[], [] ,Aeq, Beq, lb, []);

choix = find(alpha > eps);

X_VS = X(choix, :);
Y_VS = Y(choix);
Alpha_VS = alpha(choix);
c = sum(Alpha_VS.*Y_VS .* K(choix,choix(1))) - Y_VS(1); 

end

