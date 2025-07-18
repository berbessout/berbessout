clear all;
close all;

%=================[ Initialisation des parametres ]========================

Fe = 24000;
Te = 1 / Fe;
Rb = 3000;
Tb = 1 / Rb;
N_Bits = 10000;

% ===============[ Etude de modulateurs bande de base ]====================

% Modulateur 1 ---------------
Ts = Tb;
Ns = Ts/Te;
Bits = randi(0:1,1,N_Bits);
V_Bits = 2*Bits - 1;
h = ones(1, Ns);

S_mod1 = moduler(V_Bits, h, Ns);

%densité spéctrale de puissance du modulateur 1
Sx1 = pwelch(S_mod1,[], [], 2048, Fe, 'twosided');
f = linspace(-Fe/2, Fe/2, length(Sx1));
sx1_th = Ts * sinc(f*Ts).^2;


% Modulateur 2 ---------------
Ts = 2 * Tb;
Ns = Ts/Te;
Bits = randi([0 3],1,N_Bits);
V_Bits = 2*Bits - 3;
h = ones(1, Ns);

S_mod2 = moduler(V_Bits, h, Ns);

% densité spéctrale de puissance du modulateur 2
Sx2 = pwelch(S_mod2,[], [], 2048, Fe, 'twosided');
f = linspace(-Fe/2, Fe/2, length(Sx2));
Sx2_th = Ts*((sin(pi*f*Ts))./(pi*f*Ts/2)).^2;


% Modulateur 3 ---------------
Ts = Tb;
Ns = Ts/Te;
alpha = 1/2;
Bits = randi(0:1,1,N_Bits);
V_Bits = 2*Bits - 1;
L = 10;
h = rcosdesign(alpha, L, Ns);

S_mod3 = moduler(Bits, h, Ns);

% densité spéctrale de puissance du modulateur 3
Sx3 = pwelch(S_mod3,[], [], 2048, Fe, 'twosided');
f = linspace(-Fe/2, Fe/2, 2048);
Sx3_th = 1/2 * (1 + cos(pi*Ts*(abs(f) - (1-alpha)/(2*Ts))/alpha));
Sx3_th(find(abs(f(:)) > (1+alpha)/(2*Ts)) ) = 0;
Sx3_th(find(abs(f(:)) <= (1-alpha)/(2*Ts)) ) = 1;

%===[ Etude des interferences entre symbole et du critere de Nyquist ]=====

% Etude sans canal de propagation -------------------

%initialisation
bits = randi([0, 1], 1, N_Bits);
Ts = Tb;
Ns = Ts/Te;
h = ones(1, Ns);
%modulation
V_Bits = 2*bits - 1;
x = moduler(V_Bits, h, Ns);
%demodulation
z = filter(fliplr(h), 1, x);
demap = z(Ns : Ns: end)/Ns;
s_retrouve = (demap + 1)/2;

erreur_bin = sum(abs(bits-s_retrouve),2)/length(bits);

% réponse impulsionnelle globale de la chaine de transmission
g = conv(h,h);

% Etude avec canal de propagation sans bruit ----------

%initialisation
bits = randi([0, 1], 1, N_Bits);
Ts = Tb;
Ns = Ts/Te;
h = ones(1, Ns);
retard = fix(Ns/2);
%modulation
V_Bits = 2*bits - 1;
ak = kron(V_Bits, [1 zeros(1,Ns - 1)]);
x = filter(h, 1, [ak zeros(1, retard)]);
x = x(retard +1 : end);
%propagation
BW = 1000;
L=20;
n = -L/2*Ns : L/2*Ns;
hc = BW*sinc(1*n*Te*BW);
r = filter(hc, 1, [x zeros(1, L*retard)]);
r = r(L*retard + 1: end);
%demodulation
n0 = 1;
z = filter(fliplr(h), 1, [r zeros(1, retard)]);
z = z(retard + 1 : end);

demap = z(n0 : Ns: end)/Ns;
demap = demap > 0.5;
s_retrouve = (demap + 1)/2;
erreur_bin = sum(abs(bits-s_retrouve),2)/length(bits);

% réponse impulsionnelle globale de la chaine de transmission
g = conv(fliplr(h), conv(hc, h));

%========[ Etude de l'impact du bruit et du filtrage adapté ]==============

%chaine 1

%initialisation
bits = randi([0, 1], 1, N_Bits);
Ts = Tb;
Ns = Ts/Te;
%modulation
V_Bits = 2*bits - 1;
ak = kron(V_Bits, [1 zeros(1,Ns - 1)]);
h = ones(1, Ns);
retard = fix(Ns/2);
x = filter(h, 1, [ak zeros(1, retard)]);
x = x(retard +1 : end);
%propagation x bruitage
Eb_Sur_N0 = 1;
Px = mean(abs(x).^2, 2);
M = 2;
sigma_n = Px * Ns / ( 2*log2(M)*(10).^Eb_Sur_N0);
bruit = sigma_n * randn(1, length(x));
x = x + bruit;
%demodulation
n0 = 1;
z = filter(fliplr(h), 1, [x zeros(1, retard)]);
z = z(retard + 1 : end);
demap = z(n0 : Ns: end)/Ns;
demap = demap > 0;
s_retrouve = (demap + 1)/2;
erreur_bin = sum(abs(bits-s_retrouve),2)/length(bits);


EB_SUR_N0_DB = linspace(0, 8, 16);
Teb_exp1 =[];
for i = 1:16
    teb_exp = 0;
        for j = 1:100
            teb_exp = teb_exp + TEB_chaine1(EB_SUR_N0_DB(i), N_Bits, Ns);
        end
        teb_exp1 = teb_exp/100;
        Teb_exp1 = [Teb_exp1 teb_exp];
end

%teb théorique 
Eb_Sur_N0_db = linspace(0,8,8*2+1);
Eb_Sur_N0 = 10.^(Eb_Sur_N0_db/10);
P1 = qfunc(sqrt(2*Eb_Sur_N0));


%chaine 2

%initialisation
bits = randi([0, 1], 1, N_Bits);
Ts = Tb;
Ns = Ts/Te;
%modulation
V_Bits = 2*bits - 1;
ak = kron(V_Bits, [1 zeros(1,Ns - 1)]);
h = ones(1, Ns);
retard = fix(Ns/2);
x = filter(h, 1, [ak zeros(1, retard)]);
x = x(retard +1 : end);
%propagation x bruitage
Eb_Sur_N0 = 1;
Px = mean(abs(x).^2, 2);
M = 2;
sigma_n = Px * Ns / ( 2*log2(M)*(10).^Eb_Sur_N0);
bruit = sigma_n * randn(1, length(x));
x = x + bruit;
%demodulation
n0 = 1;
h2 = [ones(1, Ns/2) zeros(1, Ns/2)];
z = filter(h2, 1, [x zeros(1, retard/2)]);
z = z(retard/2 + 1 : end);
demap = z(n0 : Ns: end)/Ns;
demap = demap > 0;
s_retrouve = (demap + 1)/2;
erreur_bin = sum(abs(bits-s_retrouve),2)/length(bits);


EB_SUR_N0_DB = linspace(0, 8, 16);
Teb_exp2 =[];
for i = 1:16
    teb_exp = 0;
        for j = 1:100
            teb_exp = teb_exp + TEB_chaine2(EB_SUR_N0_DB(i), N_Bits, Ns);
        end
        teb_exp = teb_exp/100;
        Teb_exp2 = [Teb_exp2 teb_exp];
end

%teb théorique 
Eb_Sur_N0_db = linspace(0,8,8*2+1);
Eb_Sur_N0 = 10.^(Eb_Sur_N0_db./10);
P2 = qfunc(sqrt(Eb_Sur_N0));


%chaine 3

%initialisation
Bits = randi([0 1],1,N_Bits);
Ts = 2*Tb;
Ns = Ts/Te;
%modulation
code_distance = -2*Bits(2:2:end) + 3;
code_signe = 2*Bits(1:2:end) -1;
V_Bits = code_signe .* code_distance;
ak = kron(V_Bits, [1 zeros(1,Ns - 1)]);
h = ones(1, Ns);
retard = fix(Ns/2);
x = filter(h, 1, [ak zeros(1, retard)]);
x = x(retard +1 : end);
%propagation x bruitage
Eb_Sur_N0 = 1;
Px = mean(abs(x).^2, 2);
M = 2;
sigma_n = Px * Ns / ( 2*log2(M)*(10).^Eb_Sur_N0);
bruit = sigma_n * randn(1, length(x));
x = x + bruit;
%demodulation
n0 = 16;
z = filter(fliplr(h), 1, [x zeros(1, retard)]);
demap = z(n0 : Ns: n0 + Ns*N_Bits/2-1);
s_retrouve = zeros(1, N_Bits);
s_retrouve(1:2:end) = demap > 0;
s_retrouve(2:2:end) = abs(demap) < 32;

erreur_bin = sum(abs(bits-s_retrouve),2)/length(bits);

EB_SUR_N0_DB = linspace(0, 8, 16);
Teb_exp3 =[];
for i = 1:16
    teb_exp = 0;
        for j = 1:100
            teb_exp = teb_exp + TEB_chaine3(EB_SUR_N0_DB(i), N_Bits, Ns);
        end
        teb_exp = teb_exp/100;
        Teb_exp3 = [Teb_exp3 teb_exp];
end

%teb théorique 
Eb_Sur_N0_db = linspace(0,8,8*2+1);
Eb_Sur_N0 = 10.^(Eb_Sur_N0_db/10);
P3 = (3/4)*qfunc(sqrt((4/5)*Eb_Sur_N0));