function [X_VS,Y_VS,Alpha_VS,c,code_retour] = SVM_3_souple(X,Y,sigma, lambda)

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

f = -ones(n,1);
H = (Y.*Y').* K;
Aeq = Y';
Beq = 0;
lb = zeros(n,1);
ub = lambda * ones(size(f));
[alpha,~,code_retour] = quadprog(H, f ,[], [] ,Aeq, Beq, lb, ub);

indices = find(alpha > eps);

X_VS = X(indices,:);
Y_VS = Y(indices,:);
Alpha_VS = alpha(indices);
indices_corrects = find(Alpha_VS < lambda - eps);
temp = K(indices,indices(1));
c = mean(Y_VS(indices_corrects) - K(indices_corrects, indices) * (Alpha_VS .* Y_VS));
end

