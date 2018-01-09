clc
clear all
close all

X = csvread('VNA_lumped_inductor2.csv',1,0,[1 0 201 4]);
load('lumped.mat');
f = X(:,1);
s11_24 = X(:,2) + 1i*X(:,3);
z11_24 = 50.*(1+s11_24)./(1-s11_24);
s11_40 = X(:,4) + 1i*X(:,5);
z11_40 = imag(50.*(1+s11_40)./(1-s11_40));

f_ads = lumped_tester.dataBlocks(2).data.independent(1,:);
z_ads = imag(lumped_tester.dataBlocks(2).data.dependents(1,:));
figure;
plot(f_ads,z_ads,f,z11_40);

figure
plot(f,abs(z11_24));
%%

data = read(rfdata.data,'point1nHInd.s2p');
%S_measured = sparameters('point1nHInd.s2p');
s_params = extract(data,'S_PARAMETERS',50);
s11 = s_params(1,1,:);
s21 = s_params(2,1,:);
for i = 1:1000
    s11_1(1,i) = s11(1,1,i);
end
for i = 1:1000
    s21_1(1,i) = s21(1,1,i);
end

z11_vna = 50.*(1+s11_1)./(1-s11_1);
y = linspace(1e9,10e9,1000);
plot(y,z11_vna);

plot(f,z11_24,f,z11_40,y,z11_vna);
legend('24','40','newvna')