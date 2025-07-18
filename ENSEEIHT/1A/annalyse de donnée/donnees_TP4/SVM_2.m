function [X_VS,w,c,code_retour] = SVM_2(X,Y)

    eps = 1e-6;

    f = -ones(size(Y));
    H = (Y*Y') .* (X*X');
    Aeq = Y';
    Beq = 0;
    lb = zeros(size(f));

    [alpha,~,code_retour] = quadprog(H,f,[],[],Aeq,Beq,lb,[]);

    w = X'*(alpha.*Y);
    
    X_VS = X(alpha > eps,:);
    Y_VS = Y(alpha > eps,:);
    c = mean(X_VS*w - Y_VS);
end

