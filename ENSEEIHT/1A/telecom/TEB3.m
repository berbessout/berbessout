function Teb = TEB3(EbN0_db, Nbits, Ns)
Fe = 24000;
Te = 1 / Fe;
rolloff = 0.35;
L = 10;
% Génération des données à transmettre
bits = randi([0 1], 1, Nbits); 

%Mapping 8-PSK
V_bits = 4*bits(1:3:end)+ 2*bits(2:3:end) + bits(3:3:end);
psk_symbols = pskmod(V_bits, 8, pi/8);

% Filtre de mise en forme en racine de cosinus surélevé
h = rcosdesign(rolloff, L, Ns);

% Construction du peigne de dirack
peigneDirack = kron(psk_symbols, [1 zeros(1,Ns - 1)]);
xe = filter(h, 1, [peigneDirack zeros(1, L*Ns/2)]);
xe = xe(L*Ns/2 + 1 : end);

% Ajout du bruit
Px = mean(abs(xe).^2, 2);
M = 8;
EbN0 = 10^(EbN0_db/10);
sigma_n = Px * Ns / ( 2*log2(M)*EbN0);
bruit = sigma_n * randn(1, length(xe));
x = xe + bruit;

% Demaping
x_retrouve = filter(h, 1, [x zeros(1, L*Ns)]);

x_retrouve =x_retrouve(L*Ns+1:Ns:length(x_retrouve)-1);
bits_retrouve = pskdemod(x_retrouve, 8);
bits_retrouve = int2bit(bits_retrouve,3);
bits_retrouve = bits_retrouve(:)';

Teb = sum(abs(bits-bits_retrouve))/Nbits;
end