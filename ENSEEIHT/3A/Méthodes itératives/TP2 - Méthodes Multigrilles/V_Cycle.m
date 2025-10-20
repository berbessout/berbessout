function v = V_Cycle(Ah,rhsf,u0,omega,nu1, nu2, N)
    % Base case: smallest grid has two interior points -> N == 2 means size(A)=1
    if N <= 2
        % Direct solve on the coarsest grid
        v = Ah \ rhsf;
        return;
    end

% 1) Intergrid transfer operators (constructed inline)
    n_fine = N - 1;         % number of interior points on fine grid
    n_coarse = N/2 - 1;     % number of interior points on coarse grid
    % Build interpolation I_{2h}^h of size (n_fine x n_coarse)
    % using standard linear interpolation with stencil [1 2 1]/2
    ii = zeros(3*n_coarse, 1);
    jj = zeros(3*n_coarse, 1);
    vv = zeros(3*n_coarse, 1);
    for j = 1:n_coarse
        i = 2*j - 1;
        base = 3*(j-1);
        ii(base + (1:3)) = [i; i+1; i+2];
        jj(base + (1:3)) = [j; j; j];
        vv(base + (1:3)) = 0.5 * [1; 2; 1];
    end
    I2hh = sparse(ii, jj, vv, n_fine, n_coarse);
    % Full-weighting restriction I_h^{2h}
    Ih2h = 0.5 * I2hh';

% 2) Pre-smoothing: nu1 steps of weighted Jacobi (inline)
    n = size(Ah, 1);
    Dinv = spdiags(1./diag(Ah), 0, n, n);
    M = speye(n) - omega * (Dinv * Ah);
    c = omega * (Dinv * rhsf);
    u_pre = u0;
    for k = 1:nu1
        u_pre = M * u_pre + c;
    end

% 3) Residual on fine grid
    r_h = rhsf - Ah * u_pre;

% 4) Restrict residual to coarse grid
    r_H = Ih2h * r_h;

% 5) Coarse grid operator via Galerkin projection
    A_H = Ih2h * Ah * I2hh;

% 6) Coarse grid solve (recursive V-cycle with zero initial guess)
    u0_H = zeros(size(A_H,1),1);
    e_H = V_Cycle(A_H, r_H, u0_H, omega, nu1, nu2, N/2);

% 7) Prolongate coarse error to fine grid
    e_h = I2hh * e_H;

% 8) Correct fine-grid approximation
    u_corr = u_pre + e_h;

% 9) Post-smoothing: nu2 steps of weighted Jacobi (inline)
    v = u_corr;
    for k = 1:nu2
        v = M * v + c;
    end
end