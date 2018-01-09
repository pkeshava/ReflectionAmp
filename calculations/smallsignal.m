%% Small signal analysis for Negative Resistance... here we go again...
% Tuesday Oct 24th 2017


gm = 0.003;
Beta = 394.4;
Cbe = 2.27e-12;
f = 1e9:0.1e9:12e9;
w = 2*pi*f;
s = 1i*w;
rpi = 134.385e3;
gpi = 1/rpi;

Ce = 1e-12;
Lb = 2e-9;
Cce = 1e-9;
Cb = 5.1e-12;
Re = 1e3;
Ge = 1/Re;

X = s.*Cbe + gpi + s.*Cb./(1+s.^2.*Cb.*Lb);
Y = s.*Cce + Ge + s.*Ce + gpi + s.*Cbe + gm - gm.*(s.*Cbe+gpi)./X...
    - (s.^2.*Cbe.^2+gpi.*s.*Cbe)./X - gm.*(s.*Cbe+gpi)./X;
Z = gm.*s.*Cce./Y.*(s.*Cbe+gpi)./X - gm.*s.*Cce./Y + s.*Cce - s.^2.*Cce.^2./Y;

Zin = 1./(Z);

RZ = real(Zin);
IZ = imag(Zin);

plot(f,RZ,'r',f,IZ,'b');
xlabel('frequency');
ylabel('Impedance (OHMs)');
legend('R(Zin)','I(Zin)');
title('Input Impedance of Negative Resistance Device');

%% No feedback
gm = 0.003;
Beta = 394.4;
Cbe = 2.27e-12;
f = 1e9:0.1e9:12e9;
w = 2*pi*f;
s = 1i*w;
rpi = 134.385e3;
gpi = 1/rpi;

Ce = 1e-12;
Lb = 2e-9;
Cce = 1e-9;
Cb = 5.1e-12;
Re = 300;
Ge = 1/Re;

X = s.*Cbe + gpi + s.*Cb./(1+s.^2.*Cb.*Lb);
Y = s.*Cce + Ge + s.*Ce + gpi + s.*Cbe + gm - gm.*(s.*Cbe+gpi)./X...
    - (s.^2.*Cbe.^2+gpi.*s.*Cbe)./X - gm.*(s.*Cbe+gpi)./X;
Z = gm.*s.*Cce./Y.*(s.*Cbe+gpi)./X - gm.*s.*Cce./Y + s.*Cce - s.^2.*Cce.^2./Y;

Zin = 1./(Z);

RZ = real(Zin);
IZ = imag(Zin);

plot(f,RZ,'r',f,IZ,'b');
xlabel('frequency');
ylabel('Impedance (OHMs)');
legend('R(Zin)','I(Zin)');
title('Input Impedance of Negative Resistance Device');
%% Hartley Version using BJT high frequency model
clear all
close all
clc

gm = 0.003;
Beta = 394.4;
Cmu = 4e-13;
Cpi = 2.7e-13;
Ccs = .15e-12;
f = 1e9:0.1e9:10e9;
w = 2*pi*f;
s = 1i*w;
rpi = 134.385e3;
rx = 18;
ro = 1.7e6;
rmu = 10e13;
gpi = 1/rpi;
gx = 1/rx;
go = 1/ro;
gmu = 1 /rmu;


Ce = .05e-12;
Lb = 2.3e-9;
Lc = 1e-9;
Cb = 3e-12;
Cc = 12e-12;
Re = 500;
ge = 1/Re;


A = 1 + s.*Cb./((s.^2.*Cb.*Lb +1).*gx);
B = s.*Cpi + gpi;
C = s.*Cmu + gmu;
D = A.*s.*Cpi + A.*gpi + A.*s.*Cmu + A.*gmu - gx + gx.*A;
E = s.*Cpi + gpi + s.*Ce + ge + go + s.*Ccs + gm - gm.*A.*B./D ...
    - s.*Cpi.*A.*B./D - gpi.*A.*B./D;
F = s.*Cpi.*A.*C./D + gpi.*A.*C./D + go + s.*Ccs + gm.*A.*C./D;
G = s.*Ccs + s.*Cc + go + s.*Cmu + gmu - gmu.*(F.*A.*B./(E.*D) ...
    + A.*C./D) - gm.*(F.*A.*B./D + A.*C./D) + gm.*F./E ...
    - s.*Cmu.*(F.*A.*B./D + A.*C./D) - s.*Ccs.*F./E - go.*F./E;
H = s.*Cc - s.^2.*Cc.^2./G + 1./(s.*Lc);

Zin = 1./H;
RZ = real(Zin);
IZ = imag(Zin);

plot(f,RZ,'r',f,IZ,'b');


