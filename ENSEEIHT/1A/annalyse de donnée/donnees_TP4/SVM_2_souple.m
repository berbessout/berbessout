function [X_VS,w,c,code_retour] = SVM_2_souple(X,Y, lambda)
    eps = 1e-6;
    n= size(X, 1);

    f = -ones(n, 1);
    H = (Y*Y') .* (X*X');

    Aeq = Y';
    Beq = 0;

    lb = zeros(n, 1);
    ub = lambda * ones(n, 1);

    [alpha,~,code_retour] = quadprog(H,f,[],[],Aeq,Beq,lb,ub);

    indices = find(alpha > eps);

    X_VS = X(indices,:);
    Y_VS = Y(indices,:);
    alpha_VS = alpha(indices);

    w = sum(alpha_VS.*Y_VS.*X_VS)';


    indices_corrects = find(alpha_VS < lambda);

    c = mean(X_VS(indices_corrects, :)*w - Y_VS(indices_corrects, :));
end

