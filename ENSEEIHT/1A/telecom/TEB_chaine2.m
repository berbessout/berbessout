function Teb = TEB_chaine2(EbN0_db, N_Bits, Ns)
%TEB_CHAINE1 Summary of this function goes here
%   Detailed explanation goes here
bits = randi([0, 1], 1, N_Bits);
%modulation
V_Bits = 2*bits - 1;
ak = kron(V_Bits, [1 zeros(1,Ns - 1)]);
h = ones(1, Ns);
x = filter(h, 1, ak);
%propagation x bruitage
EbN0 = 10^(EbN0_db/10);
Px = mean(abs(x).^2);
M = 2;
sigma_n = sqrt(Px * Ns / ( 2*log2(M)*EbN0));
bruit = sigma_n * randn(1, length(x));
x = x + bruit;
%demodulation
h2 = [ones(1, Ns/2) zeros(1, Ns/2)];
z = filter(h2, 1, x);
demap = z(3*Ns/4 : Ns: end)/Ns;

demap(demap > 0) = 1;
demap(demap < 0) = 0;

Teb =sum(abs(bits-demap),2)/N_Bits;
end