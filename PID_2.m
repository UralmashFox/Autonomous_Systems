clc
clear all
close all
S = [3 7];
G = [10 2];
r = 0.04;
R = 0.12;
phi_0 = pi/6;
d_t = 0.01;

d_L = sqrt((S(1) - G(1))^2 + (S(2) - G(2))^2);
d_x = S(1) - G(1);
d_y = S(2) - G(2);

phi_des = atan2(-(G(2)-S(2)),-(G(1)-S(1)));
d_phi = phi_des - phi_0;
delta_phi = d_phi
Kp = 60;
Kd = 40;
Ki = 2;
integer_omega = 0;
integer_axis = 0;
phi_now = phi_0;
L_now = d_L;
x_now = S(1);
y_now = S(2);
i = 0
while abs(d_L) > 0.01
    figure(1)
        hold on
        plot(x_now,y_now,'o')
        xlim([0 12])
        ylim([0 12])
        Omega = Kp*d_phi+Kd*d_phi*d_t
        if abs(rad2deg(d_phi)) > 0.05
            vl = Omega*3*R
            vr = Omega*R
            omega_rr = vr/r
            omega_ll = vl/r
            Phi = Omega*d_t
            d_phi = d_phi -  Phi
            phi_now = phi_now + Phi
        else
            omega_rr = Kp*d_L+Kd*d_L*d_t
            omega_ll = Kp*d_L+Kd*d_L*d_t
            vl = omega_ll*r
            vr = omega_rr*r
        end
        V = (vl+vr)/2
        
        x = V*cos(phi_now)*d_t
        x_now = x_now - x
        
        y = V*sin(phi_now)*d_t
        y_now = y_now - y
        
        L = sqrt(x^2+y^2)
        d_L = d_L - L
        
        i = i+1
end
            