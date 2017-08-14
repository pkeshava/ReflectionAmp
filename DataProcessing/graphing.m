%% Aug9 2017 First Legit Data Processing
clear all
clc
close all

load('data/ADS.mat');
S = RefAmpWithTrans.dataBlocks.data.dependents(1,:);
f = RefAmpWithTrans.dataBlocks.data.independent(1,:);
S11_mag = abs(S);
GdB = 20*log10(S11_mag);
[data] = xlsread('data/OMG2copy.xlsx','2','A2:D1602');
[data_good] = xlsread('data/FIRSTGOOD.xlsx','1','A2:D1602');
xlabel('frequency');
ylabel('S11 (dB)');
% Biasing changed to include resistors. Simulations updated

plot(f,GdB);
hold on
plot(data(:,1),data(:,2));
title('Bias Conditions --- Vb = 1.461V & Vc = 0.627V @ 325uA --- INCIDENT POWER = -30dBm');
legend('Simulation','Measured'...
    ,'Location','southwest','Orientation','horizontal');
xlabel('frequency');
ylabel('S11 (dB)');
hold off

% Incident power on VNA turned down to VNA to -55dBm. 
figure;
plot(f,GdB);
hold on
plot(data_good(:,1),data_good(:,2));
title('Bias Conditions --- Vb = 1.461V & Vc = 0.627V @ 325uA --- INCIDENT POWER = -55dBm');
legend('Theoretical','Meaured'...
    ,'Location','southwest','Orientation','horizontal');
xlabel('frequency');
ylabel('S11 (dB)');
hold off

%[data_good_z] = xlsread('data/FIRSTGOOD.xlsx','2','A2:D1602');
% figure;
% plot(data_good_z(:,1),data_good_z(:,2));
% legend('Bias Conditions --- Vb = 1.461V & Vc = 0.627V @ 325uA');
% [data_so_good_z] = xlsread('data/RefAmp_V1_Board2_Good_Data.xlsx','2','A2:D1602');
% xlabel('frequency');
% ylabel('S11 (dB)');

% Zoomed in to Observe Q
[data_so_good_z] = xlsread('data/RefAmp_V1_Board2_Good_Data.xlsx','2','A2:D1602');
figure;
plot(data_so_good_z(:,1),data_so_good_z(:,2));
xlabel('frequency');
ylabel('S11 (dB)');
title('Observed Q Measured');

%% No feeback
clear all
clc
close all
% Measure unit #2 without feedback components and compare to simulation
load('data/debugging/ADS_no_feedback.mat');
S = RefAmpNoFeedback.dataBlocks.data.dependents(1,:);
f = RefAmpNoFeedback.dataBlocks.data.independent(1,:);
S11_mag = abs(S);
GdB = 20*log10(S11_mag);
[data] = xlsread('data/debugging/nofeedback.xlsx','1','A2:D1602');

plot(f,GdB);
hold on
plot(data(:,1),data(:,2));
title('Feedback Components Removed');
legend('Theoretical','Meaured'...
    ,'Location','southwest','Orientation','horizontal');
xlabel('frequency');
ylabel('S11 (dB)');
hold off
% Adjusted
figure;
plot(f,GdB);
hold on
plot(data(181:1580,1),data(1:1400,2));
title({'Feedback Components Removed'; '& ADJUSTED FREQUENCY FOR VISUALIZATION'});
legend('Theoretical','Meaured'...
    ,'Location','southwest','Orientation','horizontal');
xlabel('frequency');
hold off

% Re-cal'd with larger frequency range
load('data/debugging/ADS_no_feedback_wide.mat');
S = RefAmpNoFeedback.dataBlocks.data.dependents(1,:);
f = RefAmpNoFeedback.dataBlocks.data.independent(1,:);
S11_mag = abs(S);
GdB = 20*log10(S11_mag);
[data] = xlsread('data/debugging/no_feedback_wide.xlsx','2','A2:D1602');

figure;
plot(f,GdB);
hold on
plot(data(:,1),data(:,2));
title('Feedback Components Removed --- VNA recalibrated for Wider Bandwidth');
legend('Theoretical','Meaured'...
    ,'Location','southwest','Orientation','horizontal');
xlabel('frequency');
ylabel('S11 (dB)');
hold off
% Adjusted
figure;
plot(f,GdB);
hold on
plot(data(181:1580,1),data(1:1400,2));
title({'Feedback Components Removed --- VNA recalibrated for Wider Bandwidth'...
    ;'& ADJUSTED FREQUENCY FOR VISUALIZATION'});
legend('Theoretical','Meaured'...
    ,'Location','southwest','Orientation','horizontal');
xlabel('frequency');
ylabel('S11 (dB)');
hold off
