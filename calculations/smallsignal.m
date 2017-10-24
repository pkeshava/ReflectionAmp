%% Small signal analysis for Negative Resistance... here we go again...
% Tuesday Oct 24th 2017


gm = 0.003;
Beta = 394.4;
Cbe = 0.27e-12;
f = 1e9:0.1e9:12e9;
w = 2*pi*f;
s = 1i*w;
rpi = 134.385e3;
gpi = 1/rpi;

Ce = 1e-12;
Lb = 1.4e-9;
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

plot(f,RZ,f,IZ)