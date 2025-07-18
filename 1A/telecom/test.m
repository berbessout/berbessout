clear all;
close all;

Fe = 24000;
Te = 1 / Fe;
Rb = 3000;
Tb = 1 / Rb;
N_Bits = 10000;
fp = 2000;
Ts = Tb;
Ns = Ts/Te;


Bits = randi(0:1,1,N_Bits);
V_Bits = 2*Bits - 1;
h = ones(1, Ns);
ak = kron(Bits, [1 zeros(1, Ns-1)]);
S_mod = filter(h,1,ak);

x = filter(h, 1, S_mod);

t = 0:Te:Te*(length(x)-1);
expo = exp(2*1i*pi*fp*t);

Sx1 = pwelch(x,[], [], 2048, Fe, 'twosided')';
Sx2 = pwelch(x.*expo,[], [], 2048, Fe, 'twosided')';
f = linspace(-Fe/2, Fe/2, length(Sx2));

semilogy(f, fftshift(Sx1));
hold on;
semilogy(f, fftshift(Sx2));
