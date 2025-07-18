function Teb = TEB(EbN0_db, Nbits, Ns)
Fe = 24000;
Te = 1 / Fe;
Fp = 2000;
rolloff = 0.35;
L = 10;
% Génération des données à transmettre
bits = randi([0 1], 1, Nbits); 
% Mapping QPSK
SI = 1 - 2*bits(1:2:Nbits);
SQ = 1 - 2*bits(2:2:Nbits);
qpsk_symbols = SI + 1i*SQ;
% Filtre de mise en forme en racine de cosinus surélevé
h = rcosdesign(rolloff, L, Ns);
% Construction du peigne de dirack
peigneDirack = kron(qpsk_symbols, [1 zeros(1,Ns - 1)]);
xe = filter(h, 1, [peigneDirack zeros(1, L*Ns/2)]);
xe = xe(L*Ns/2 + 1 : end);
% Transposition de fréquence
t = 0:Te:Te*(length(xe)-1);
expo = exp(2*1i*pi*Fp*t);
x = real(xe.*expo);
%propagation x bruitage
EbN0 = 10^(EbN0_db/10);
Px = mean(abs(x).^2);
M = 4;
sigma_n = sqrt(Px * Ns / ( 2*log2(M)*EbN0));
bruit = sigma_n * randn(1, length(x));
x = x + bruit;
% Démodulation
x = x.*conj(expo);
z = filter(h, 1, [x zeros(1, L*Ns/2)]);
z = z(L*Ns/2 + 1:end);

n0 =16;
z = z(1 : Ns: 1 + Ns*Nbits/2-1);
s_retrouve = zeros(1, Nbits);
s_retrouve(1:2:end) = (real(z) < 0);
s_retrouve(2:2:end) = (imag(z) < 0);

Teb = sum(abs(bits-s_retrouve))/Nbits;
end