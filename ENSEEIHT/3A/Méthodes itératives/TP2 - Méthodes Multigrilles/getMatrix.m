function A = getMatrix(N)
    h = 1/N;
    % This function generates the finite difference matrix A to solve the equation -u'' = f
    A = (1/(h*h))*sparse(diag(2*ones(1,N-1), 0) + diag((-1)*ones(1,N-2), 1) + diag((-1)*ones(1,N-2), -1));
end