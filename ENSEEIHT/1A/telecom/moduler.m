function S_mod = moduler(Bits,h, Ns)
%MODULER Summary of this function goes here
%   
ak = kron(Bits, [1 zeros(1, Ns-1)]);
S_mod = filter(h,1,ak);

end

