function Teb = TEB_chaine3(EbN0_db, N_Bits, Ns)
%TEB_CHAINE1 Summary of this function goes here
%   Detailed explanation goes here
bits = randi([0, 1], 1, N_Bits);
%modulation 
code_distance = -2*bits(2:2:end) + 3;
code_signe = 2*bits(1:2:end) -1;
V_Bits = code_signe .* code_distance;
ak = kron(V_Bits, [1 zeros(1,Ns - 1)]);
h = ones(1, Ns);
x = filter(h, 1,ak);
%propagation x bruitage
EbN0 = 10^(EbN0_db/10);
Px = mean(abs(x).^2);
M = 4;
sigma_n = sqrt(Px * Ns / ( 2*log2(M)*EbN0));
bruit = sigma_n * randn(1, length(x));
x = x + bruit;
%demodulation
n0 = Ns;
z = filter(h, 1, x);
demap = z(n0 : Ns: end);
s_retrouve = zeros(1, N_Bits);
s_retrouve(1:2:end) = demap > 0;
s_retrouve(2:2:end) = abs(demap) < 32;

Teb = sum(abs(bits-s_retrouve))/N_Bits;
end