function v = V_Cycle(A, rhsf, u0, omega, nu1, nu2, N)
    % 1. Setup of intergrid transfer operators
    I2hh = interpol(N);  % Interpolation operator
    Ih2h = restriction(N); % Restriction operator from TP1 helper
    
    % 2. nu1 steps of weighted Jacobi smoothing using TP1 helper
    v = weighted_jacobi(A, u0, rhsf, omega, nu1);
    
    % 3. Computation of residual
    r = rhsf - A*v;
    
    % 4. Restriction of residual
    r2h = Ih2h * r;
    
    % 5. Construction of coarse grid matrix via Galerkin projection
    A2h = Ih2h * A * I2hh;
    
    % 6. Coarse grid solve
    e2h = A2h \ r2h;
    
    % 7. Interpolation of coarse grid error
    eh = I2hh * e2h;
    
    % 8. Update of solution
    v = v + eh;
    
    % 9. nu2 steps of weighted Jacobi smoothing using TP1 helper
    v = weighted_jacobi(A, v, rhsf, omega, nu2);
end


