%% Not Powered
% NOTE: Averaging and smoothing used on VNA to reduce noise. Noise is 
% present because incident power is -60dBm so the amplifier operates
% in the proper setting. 

clear all
clc


[data_VNA] = xlsread('DataFiles/Jan11_2.xlsx','7','A2:D1602');
S11_VNA = data_VNA(:,2);
load('DataFiles/unpoweredExtendedf.mat');
S11_sim = data_analysis.dataBlocks.data.dependents(1,:);
f_sim = data_analysis.dataBlocks.data.independent(1,:);
S11_sim_dB = 20*log10(abs(S11_sim));

% Convert to Z Parameters
    % NOTE Z11 not acutally used b/c a better way to do this is to
    % just grab the data from the VNA in Smith format
    
Z11_sim = 50.*(1+S11_sim)./(1-S11_sim);
[Z11_meas, ~, ~, ~, S11_meas_dB, f_meas]= graphImpedance(data_VNA);
% As is done below

[data_VNA_z] = xlsread('DataFiles/Jan11_2.xlsx','8','A2:D1602');
S_11 = data_VNA_z(:,2) + 1i*data_VNA_z(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);


figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11),f_sim,imag(Z11_sim),f_sim,real(Z11_sim))

figure;
plot(f_sim,S11_sim_dB,f_meas,S11_VNA);

% Setup touchsone file and write it
    %S50 = reshape(S_11,[1,1,1601]);
    %rfwrite(S50, f_meas, 'TestRF.s1p')
    
S = sparameters('DataFiles/touchstone/unpowered_extended.s1p');
S_11_smith = rfparam(S,1,1);
S_ADS = sparameters('DataFiles/touchstone/unpowered_impedance_ADS.s1p');
S_11_smith_ADS = rfparam(S_ADS,1,1);
figure;
s = smithplot(S_11_smith);
add(s, S_11_smith_ADS);


%% asTested

load('DataFiles/asTestedExtendedf.mat');
S11_sim = data_analysis.dataBlocks.data.dependents(1,:);
f_sim = data_analysis.dataBlocks.data.independent(1,:);
S11_sim_dB = 20*log10(abs(S11_sim));

[data_VNA] = xlsread('DataFiles/Jan11_2.xlsx','5','A2:D1602');
S11_VNA = data_VNA(:,2);
f_meas = data_VNA(:,1);


% Convert to Z Parameters
    % NOTE Z11 not acutally used b/c a better way to do this is to
    % just grab the data from the VNA in Smith format
Z11_sim = 50.*(1+S11_sim)./(1-S11_sim);
[Z11_meas, ~, ~, ~, S11_meas_dB, f_meas]= graphImpedance(data_VNA);

% As is done below

[data_VNA_z] = xlsread('DataFiles/Jan11_2.xlsx','6','A2:D1602');
S_11 = data_VNA_z(:,2) + 1i*data_VNA_z(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);


% Setup touchsone file and write it
    % S50 = reshape(S_11,[1,1,1601]);
    % rfwrite(S50, f_meas, 'DataFiles/touchstone/asTestedExtended.s1p')
S = sparameters('DataFiles/touchstone/asTestedExtended.s1p');
S_11_smith = rfparam(S,1,1);
figure;
smithchart(S_11_smith)

figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11),f_sim,imag(Z11_sim),f_sim,real(Z11_sim))

figure;
plot(f_sim,S11_sim_dB,f_meas,S11_VNA);


%% Original Design
% Note the impedance analysis for this is not that intersting 
% because the resistance goes to zero as predicted by
% steady state oscialltion theory

load('DataFiles/OriginallyDesigned.mat');
S11_sim = data_analysis.dataBlocks.data.dependents(1,:);
f_sim = data_analysis.dataBlocks.data.independent(1,:);
S11_sim_dB = 20*log10(abs(S11_sim));

[data_VNA] = xlsread('DataFiles/Jan11.xlsx','3','A2:D1602');
S11_VNA = data_VNA(:,2);
f_meas = data_VNA(:,1);

% Convert to Z Parameters
Z11_sim = 50.*(1+S11_sim)./(1-S11_sim);
[Z11_meas, ~, ~, ~, S11_meas_dB, f_meas]= graphImpedance(data_VNA);

figure;
plot(f_sim,S11_sim_dB,f_meas,S11_VNA);

figure;
plot(f_meas,imag(Z11_meas),f_meas,real(Z11_meas),f_sim,imag(Z11_sim),f_sim,real(Z11_sim))


%% 3 Units comparison
clear all
close all
[data_VNA] = xlsread('DataFiles/Jan11_2.xlsx','5','A2:D1602');
S11_VNA = data_VNA(:,2);
f_meas = data_VNA(:,1);
[data_VNA_2] = xlsread('DataFiles/jan15_unit2.xlsx','3','A2:D1602');
S11_VNA_2 = data_VNA_2(:,2);
f_meas2 = data_VNA_2(:,1);
[data_VNA_3] = xlsread('DataFiles/jan15_unit2.xlsx','5','A2:D1602');
S11_VNA_3 = data_VNA_3(:,2);
f_meas3 = data_VNA_3(:,1);


plot(f_meas,S11_VNA,f_meas2,S11_VNA_2,f_meas3,S11_VNA_3);
