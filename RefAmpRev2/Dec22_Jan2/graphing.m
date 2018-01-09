%% Dec 22 2017 
clear all
clc
close all

load('ADS2.mat');
S11_sim = visualization.dataBlocks(2).data.dependents(1,:);
f_sim = visualization.dataBlocks(2).data.independent(1,:);
S11_sim_mag = abs(S11_sim);
GdB = 20*log10(S11_sim_mag);
Z11_sim = 50.*(1+S11_sim)./(1-S11_sim);

% [data] = xlsread('data/OMG2copy.xlsx','2','A2:D1602');
% [data_good] = xlsread('data/FIRSTGOOD.xlsx','1','A2:D1602');
% xlabel('frequency');
% ylabel('S11 (dB)');
% Biasing changed to include resistors. Simulations updated


[data] = xlsread('AmpRev2Testingedit.xlsx','2','A2:D1602');
f = data(:,1);
S11_r = data(:,3);
S11_i = 1i*data(:,4);
S11 = S11_r+S11_i;
Z11 = 50.*(1+S11)./(1-S11);


[data2] = xlsread('jan2_2.xlsx','3','A2:D1602');
f2 = data2(:,1);
S11_r2 = data2(:,3);
S11_i2 = 1i*data2(:,4);
S112 = S11_r2+S11_i2;
Z112 = 50.*(1+S112)./(1-S112);
Z112_10 = 50*9.*(1+S112)./(1-S112);

figure;
plot(f2,imag(Z112_10),f2,real(Z112_10))
hold on
plot(f_sim,imag(Z11_sim),f_sim,real(Z11_sim))
hold off

figure;
%plot(f,20*log10(abs(S11)));
hold on
plot(f_sim,GdB);
plot(f2,20*log10(abs(S112)))
hold off