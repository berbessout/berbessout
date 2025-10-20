function ump1 = weighted_jacobi(A,um,f,omega,m)
    % Get diagonal elements of A
    D = diag(diag(A));
    
    % Initialize ump1 with um
    ump1 = um;
    
    % Apply m iterations of weighted Jacobi
    for i = 1:m
        % Calculate D^(-1)
        Dinv = sparse(inv(D));
        
        % Apply weighted Jacobi iteration formula:
        % u(m+1) = (I - wD^(-1)A)um + wD^(-1)f
        ump1 = sparse((eye(size(A)) - omega * Dinv * A) * ump1 + omega * Dinv * f);
    end
end
