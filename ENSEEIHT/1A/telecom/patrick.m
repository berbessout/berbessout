Eb_Sur_N0_db = [0: 6];
EbN0 = 10.^(Eb_Sur_N0_db./10);
Nbits = 3000;
Fe = 24000;
Te = 1 / Fe;
Rb = 3000;
M = 4;
Rs = Rb/log2(M);
Ns = Fe/Rs;
Fp = 2000;
rolloff = 0.35;
L = 10;
retard = L*Ns+1;
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
xe = filter(h, 1, [peigneDirack zeros(1, retard)]);

% Transposition de fréquence
t = [0:length(xe)-1]*Te;
expo = exp(2*1i*pi*Fp*t);
x = real(xe.*expo);
%propagation x bruitage

% Ajout du bruit

Px = mean(abs(xe).^2);
for k = 1:length(EbN0)
    sigma_n = Px * Ns / ( 2*log2(M)*EbN0(k));
    
    % Ajout du bruit complexe
    I = sqrt(sigma_n)/2 * randn(1, length(x)); % Partie réelle du bruit
    Q = sqrt(sigma_n)/2 * randn(1, length(x)); % Partie imaginaire du bruit
    r = x + I+ 1i*Q;
    % Démodulation
    re= r.*conj(expo);
    z = filter(h, 1, re);
    ze = z(retard + 1: Ns: length(z));
    
    s_retrouve = zeros(1, Nbits);
    s_retrouve(1:2:end) = (real(ze) < 0);
    s_retrouve(2:2:end) = (imag(ze) < 0);
    
    Teb(k) = sum(bits ~= s_retrouve)/Nbits;
end
figure
semilogy(Eb_Sur_N0_db, qfunc(sqrt(2*EbN0)));
hold on;
semilogy(Eb_Sur_N0_db, Teb, '+r');
legend('teb theo', 'teb exp');
