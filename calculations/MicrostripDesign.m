classdef MicrostripDesign < handle
% This class creates a microstrip object. It calculates important
% parameters including characteristic impedance, conductor loss, dielectric
% loss, effective epsilon and guided wavelength. It is largely based on
% papers by Bahl and referencing books by Pozar and Steer.

    properties
        Frequency
        omega
        lambda_0
        wavenum
        Height
        Width
        copper_t
        Sub_epsr
        Sub_lsstan
        t_H
        
        Z_0
        eps_eff
        lambda_g
        
        
    end
    methods
        function obj = MicrostripDesign(constants,input)
            obj.omega = 2*pi*input.Frequency;
            obj.lambda_0 = constants.c/input.Frequency;
            obj.Height = input.Height*constants.CF;
            obj.Width = input.Width*constants.CF;
            obj.copper_t = input.copper_t*constants.CF;
            obj.Sub_epsr = input.Sub_epsr;
            obj.Sub_lsstan = input.Sub_lsstan; 
            obj.t_H = input.copper_t/input.Height;
        end
        function [Z_0,eps_eff,lambda_g, lambda_g_q, alpha_c, alpha_d, F_t ]...
                = calc_values(obj,constants)
            
            
            if (obj.t_H > 0.005)
                if (obj.Width/obj.Height > 0.5*pi)
                    W_eff = (obj.Width + obj.copper_t/pi*(1+log(2*...
                        obj.Height/obj.copper_t)));
                else
                    W_eff = (obj.Width + obj.copper_t/pi*(1+log(4*...
                        pi*obj.Width/obj.copper_t))); 
                end
            end
            
            if (obj.t_H > 0.005)
                 W_H = W_eff/obj.Height;
            else
                 W_H = obj.Width/obj.Height;
            end
            
            if(W_H > 1)
    
                eps_eff = (obj.Sub_epsr+1)/2 + (obj.Sub_epsr-1)/2*(1 + 12/W_H)^(-1/2);
                Z_0 = eta/sqrt(eps_eff)/(W_H+1.393+0.667*log(W_H+1.444));
            else
                eps_eff = (obj.Sub_epsr+1)/2 + (obj.Sub_epsr-1)/2*((1 + 12/W_H)^(-1/2)+0.04*(1-W_H)^2);
                Z_0 = 60/sqrt(eps_eff)*log(8/W_H+0.25*W_H);
            end
            
            lambda_g = obj.lambda_0/sqrt(eps_eff);
            lambda_g_q = lambda_g/4;
       
            P = 1 - (W_H/4)^2;
            Q = 1 + 1/W_H + 1/(pi*W_H)*(log(2*obj.Height/obj.copper_t)-obj.copper_t/obj.Height);
            Rs = sqrt(pi*obj.Frequency*constants.Mu_0*constants.CuResist);
            if (W_H <= 0.5/pi)
                alpha_c = 8.68*Rs/(2*pi*Z_0*(obj.Height/10))*P*(1+ 1/W_H+ 1/(pi*W_H)*(log(4*pi*obj.Width/obj.copper_t) + obj.copper_t/obj.Width));
            elseif (W_H > 0.5/pi) && (W_H <= 2)   
                alpha_c = 8.68*Rs/(2*pi*Z_0*(obj.Height/10))*P*Q;
            else
                alpha_c = 8.68*Rs/(2*pi*Z_0*(obj.Height/10))*Q*(W_H + 2/pi*log(2*pi*exp(W_H/2+0.94)))^(-2)*(W_H + W_H/(pi*(W_H/2+0.94)));
            end
            alpha_d = 27.3*obj.Sub_epsr/(sqrt(eps_eff))*(eps_eff-1)/(obj.Sub_epsr-1)*obj.Sub_lsstan/(obj.lambda_0*10);

            if(obj.Sub_epsr > 10)
                F_t = 10.6/(obj.Height/10*sqrt(obj.Sub_epsr))*1e9;
            else
                F_t = 299792458/(2*pi*obj.Height/1000)*sqrt(2/(obj.Sub_epsr-1))*atan(obj.Sub_epsr);
            end
            
            obj.Z_0 = Z_0;
            obj.eps_eff = eps_eff;
            obj.lambda_g = lambda_g;
            
        end
        
    end
end