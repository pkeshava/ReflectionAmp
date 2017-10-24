% Ref amp tester

clear all
close all
clc

S = [-0.127 - 1i*0.840 0.078-1i*0.005;0.227+1i*1.737 -0.154-1i*0.886];

gamma_l = ((11.031+1i*31.764)-50)/(11.031+1i*31.764+50);
gamma_s = 5;
gamma_in = S(1,1)+S(1,2)*S(2,1)*gamma_l/(1-S(2,2)*gamma_l);
gamma_out = S(2,2)+S(1,2)*S(2,1)*gamma_s/(1-S(1,1)*gamma_s);

mag_gamm_in = abs(gamma_in);
deg = angle(gamma_in);

theta = linspace(0,2*pi,5000);
% Load Constants
constants = load('constants.mat');
% Define input fields for the microstrip design
input = struct('Frequency',3.2e9,'Height', 50, 'Width', 40, ...
    'copper_t', 1.4, 'Sub_epsr', 10.2, 'Sub_lsstan', 0.0023);
% create microstrip object instance
micro1 = MicrostripDesign(constants,input);
[Z_0,eps_eff,lambda_g, lambda_g_q, alpha_c, alpha_d] = ...
    calc_values(micro1,constants);