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
phi_des = atan2((G(2)-S(2)),(G(1)-S(1)));
d_phi = phi_des - phi_0;
Kp = 60;
Kd = 40;
Ki = 3;
WAYX = 0;
WAYY = 0;
integer_omega = 0;
integer_axis = 0;
phi_now = phi_0;
xlim([0 15])
ylim([0 15])
while abs(d_L) > 0.01
        while abs(rad2deg(d_phi)) > 0.05
            omega_r = Kp*d_phi+Kd*d_phi*d_t+Ki*integer_omega;
            omega_l = -(Kp*d_phi+Kd*d_phi*d_t+Ki*integer_omega);
            Vr = omega_r*r;
            Vl = omega_l*r;
            Omega = ((Vr-Vl)/(2*R));
            PHI = Omega*d_t;
            phi_now = phi_now + PHI;
            d_phi = d_phi - PHI;
            i=i+1;
            integer_omega = integer_omega + d_phi*d_t
            figure(1)
            plot([S(1)-cos(-phi_now) S(1)+cos(-phi_now)], [S(2)-sin(-phi_now) S(2)+sin(-phi_now)])
            xlim([0 12])
            ylim([0 12])
        end
    d_phi = 0;
    PHI = phi_now
    omega_r = Kp*d_L+Kd*d_L*d_t+Ki*integer_axis;
    omega_l = Kp*d_L+Kd*d_L*d_t+Ki*integer_axis;
    Vr = omega_r*r;
    Vl = omega_l*r;
    S_wheels = ((Vr+Vl)/2)*d_t;
    WAYX = WAYX + S_wheels*cos(PHI)
    WAYY = WAYY + S_wheels*sin(PHI)
    wayX = S(1)+WAYX
    wayY = S(2)+WAYY
    d_L = d_L - S_wheels
    figure(1)
    plot([wayX-cos(-phi_now) wayX+cos(-phi_now)], [wayY-sin(-phi_now) wayY+sin(-phi_now)])
    xlim([0 12])
    ylim([0 12])
    integer_axis = integer_axis + d_L*d_t
end 
figure(1)
hold on
plot(wayX, wayY, 'o','Color', 'r')
plot([S(1)-cos(-phi_0) S(1)+cos(-phi_0)], [S(2)-sin(-phi_0) S(2)+sin(-phi_0)], 'Color', '0 0 0')
plot(S(1), S(2), 'o','Color', 'r')
grid on
grid minor
