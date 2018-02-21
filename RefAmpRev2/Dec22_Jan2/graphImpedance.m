function [Z11_meas, Z11_meas_scaled, S11_meas_scaled, ...
    S11_meas_scaled_dB, S11_meas_dB, f_meas]...
    = graphImpedance(data_VNA)

    f_meas = data_VNA(:,1);
    S11_meas_r = data_VNA(:,3);
    S11_meas_i = 1i*data_VNA(:,4);
    S11_meas = S11_meas_r+S11_meas_i;
    S11_meas_dB = 20*log10(abs(S11_meas));
    Z11_meas = 50.*(1+S11_meas)./(1-S11_meas);
    Z11_meas_scaled = 50*8.*(1+S11_meas)./(1-S11_meas);
    S11_meas_scaled = (Z11_meas_scaled-50)./(Z11_meas_scaled+50);
    S11_meas_scaled_dB = 20*log10(abs(S11_meas_scaled));
end
