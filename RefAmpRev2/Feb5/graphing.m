%% Not Powered
% NOTE: Averaging and smoothing used on VNA to reduce noise. Noise is 
% present because incident power is -60dBm so the amplifier operates
% in the proper setting. 

clear all
close all
clc

%load('DataFiles/unpoweredExtendedf.mat');
%S11_sim = data_analysis.dataBlocks.data.dependents(1,:);
%f_sim = data_analysis.dataBlocks.data.independent(1,:);
%S11_sim_dB = 20*log10(abs(S11_sim));

% Convert to Z Parameters
    % NOTE Z11 not acutally used b/c a better way to do this is to
    % just grab the data from the VNA in Smith format
    
%Z11_sim = 50.*(1+S11_sim)./(1-S11_sim);
%[Z11_meas, ~, ~, ~, S11_meas_dB, f_meas]= graphImpedance(data_VNA);
% As is done below

[data_VNA_11] = xlsread('DataFiles/feb5_stubcut.xlsx','1','A2:D1602');
S_11 = data_VNA_11(:,2) + 1i*data_VNA_11(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
f_meas = data_VNA_11(:,1);

figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11))


%Setup touchsone file and write it
S50 = reshape(S_11,[1,1,1601]);
rfwrite(S50, f_meas, 'TestRF.s1p')
    
S = sparameters('TestRF.s1p');
S_11_smith = rfparam(S,1,1);
% S_ADS = sparameters('DataFiles/touchstone/unpowered_impedance_ADS.s1p');
% S_11_smith_ADS = rfparam(S_ADS,1,1);
figure;
s = smithplot(S_11_smith);
% add(s, S_11_smith_ADS);

%% Stub analysis

[data_VNA_11] = xlsread('DataFiles/feb5_2.xlsx','5','A2:D1602');
S_11 = data_VNA_11(:,2) + 1i*data_VNA_11(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11))

%Setup touchsone file and write it
S50 = reshape(S_11,[1,1,1601]);
rfwrite(S50, f_meas, 'TestRF2.s1p')
S = sparameters('TestRF2.s1p');
S_11_smith = rfparam(S,1,1);
figure;
s = smithplot(S_11_smith);

%%

[data_VNA_11] = xlsread('DataFiles/milledBoardCutStub.xlsx','1','A2:D1602');
S_11 = data_VNA_11(:,2) + 1i*data_VNA_11(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11))

%Setup touchsone file and write it
S50 = reshape(S_11,[1,1,1601]);
rfwrite(S50, f_meas, 'milledBoardCutStub.s1p')
S = sparameters('milledBoardCutStub.s1p');
S_11_smith = rfparam(S,1,1);
figure;
s = smithplot(S_11_smith);
%%

clear all
close all
clc

load('DataFiles/debug.mat');
S11_sim = debug_resonator_loading.dataBlocks.data.dependents(1,:);
f_sim = debug_resonator_loading.dataBlocks.data.independent(1,:);
S11_sim_dB = 20*log10(abs(S11_sim));
Z11_sim = 50.*(1+S11_sim)./(1-S11_sim);

plot(f_sim,real(Z11_sim),f_sim,imag(Z11_sim))

%%
clc
%close all
clear all

[data_VNA_11] = xlsread('DataFiles/stub_removed_delay.xlsx','1','A2:C1602');
S_11 = data_VNA_11(:,2) + 1i*data_VNA_11(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
f_meas = data_VNA_11(:,1);
%figure;
%plot(f_meas,imag(Z_11),f_meas,real(Z_11))

%Setup touchsone file and write it
S50 = reshape(S_11,[1,1,1601]);
rfwrite(S50, f_meas, 'stub_removed_delay.s1p')
S = sparameters('stub_removed_delay.s1p');
S_11_smith = rfparam(S,1,1);
figure;
s = smithplot(f_meas,S_11_smith);
S_hfss = sparameters('5p9G_rev2_CollectorStubWP_1port.s1p');
S_11_hfss = rfparam(S_hfss,1,1);
f_hfss = S_hfss.Frequencies;
%s = smithplot(f_hfss,S_11_hfss);
add(s, f_hfss,S_11_hfss);


%%
clear all 
clc


[data_VNA_11] = xlsread('DataFiles/collector_through.xlsx','1','A2:C1602');
[data_VNA_12] = xlsread('DataFiles/collector_through.xlsx','6','A2:C1602');
[data_VNA_21] = xlsread('DataFiles/collector_through.xlsx','3','A2:C1602');
[data_VNA_22] = xlsread('DataFiles/collector_through.xlsx','5','A2:C1602');
f_meas = data_VNA_11(:,1);

S_11 = data_VNA_11(:,2) + 1i*data_VNA_11(:,3);
S_12 = data_VNA_12(:,2) + 1i*data_VNA_11(:,3);
S_21 = data_VNA_21(:,2) + 1i*data_VNA_11(:,3);
S_22 = data_VNA_22(:,2) + 1i*data_VNA_11(:,3);
S11_50 = reshape(S_11,[1,1,1601]);
S12_50 = reshape(S_12,[1,1,1601]);
S21_50 = reshape(S_21,[1,1,1601]);
S22_50 = reshape(S_22,[1,1,1601]);
SParameter3Ddata = [S11_50 S12_50; S21_50 S22_50];

%figure;
%s = smithplot(f_meas,S_11);

rfwrite(SParameter3Ddata, f_meas, 'collector_measured_forADS.s2p')

%load('DataFiles/collector_through.mat');
%S11_sim = collector_debug.dataBlocks.data.dependents(1,:)';
%f_sim = collector_debug.dataBlocks.data.independent(1,:)';
%S11_sim_dB = 20*log10(abs(S11_sim));


%Setup touchsone file and write it

%S = sparameters('collector_through.s2p');
%S_11_smith = rfparam(S,1,1);

%add(s, f_sim,S_11_smith);

%% Unit 3 detailed analysis and compare to simulation...

clear all
clc

[VNA_unit3_unpowered] = xlsread('DataFiles/debug_resistor.xlsx','444','A2:C1602');
f_meas = VNA_unit3_unpowered(:,1);
S_11 = VNA_unit3_unpowered(:,2) + 1i*VNA_unit3_unpowered(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11))

[VNA_unit3_Vb0p75] = xlsread('DataFiles/debug_resistor.xlsx','2','A2:D1602');
f_meas = VNA_unit3_Vb0p75(:,1);
S_11 = VNA_unit3_Vb0p75(:,2) + 1i*VNA_unit3_Vb0p75(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
figure;
plot(f_meas,imag(Z_11),f_meas,real(Z_11))
hold on
[VNA_unit3_Vb0p76] = xlsread('DataFiles/debug_resistor.xlsx','3','A2:D1602');
f_meas = VNA_unit3_Vb0p76(:,1);
S_11 = VNA_unit3_Vb0p76(:,2) + 1i*VNA_unit3_Vb0p76(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
plot(f_meas,imag(Z_11),f_meas,real(Z_11))
[VNA_unit3_Vb0p77] = xlsread('DataFiles/debug_resistor.xlsx','4','A2:D1602');
f_meas = VNA_unit3_Vb0p77(:,1);
S_11 = VNA_unit3_Vb0p77(:,2) + 1i*VNA_unit3_Vb0p77(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
plot(f_meas,imag(Z_11),f_meas,real(Z_11))
[VNA_unit3_Vb0p78] = xlsread('DataFiles/debug_resistor.xlsx','5','A2:D1602');
f_meas = VNA_unit3_Vb0p78(:,1);
S_11 = VNA_unit3_Vb0p78(:,2) + 1i*VNA_unit3_Vb0p78(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
plot(f_meas,imag(Z_11),f_meas,real(Z_11))
[VNA_unit3_Vb0p79] = xlsread('DataFiles/debug_resistor.xlsx','6','A2:D1602');
f_meas = VNA_unit3_Vb0p79(:,1);
S_11 = VNA_unit3_Vb0p79(:,2) + 1i*VNA_unit3_Vb0p79(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
plot(f_meas,imag(Z_11),f_meas,real(Z_11))
[VNA_unit3_Vb0p80] = xlsread('DataFiles/debug_resistor.xlsx','7','A2:D1602');
f_meas = VNA_unit3_Vb0p80(:,1);
S_11 = VNA_unit3_Vb0p80(:,2) + 1i*VNA_unit3_Vb0p80(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
plot(f_meas,imag(Z_11),f_meas,real(Z_11))
[VNA_unit3_Vb0p81] = xlsread('DataFiles/debug_resistor.xlsx','8','A2:D1602');
f_meas = VNA_unit3_Vb0p81(:,1);
S_11 = VNA_unit3_Vb0p81(:,2) + 1i*VNA_unit3_Vb0p81(:,3);
Z_11 = 50.*(1+S_11)./(1-S_11);
plot(f_meas,imag(Z_11),f_meas,real(Z_11))

hold off
