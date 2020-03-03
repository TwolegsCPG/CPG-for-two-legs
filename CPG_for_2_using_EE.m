% CPG for two odrives using explicit euler method
clc;clear;
tmax = 2; % maximal time for ode solution
h = 0.01;
x0 = [0;pi];%initial condition
w = 10;%speed
A_L = 20;
A_R = 20; 

x_on = 0.11;
y_on = 0.2;
x_off = -0.11;
y_off = 0.2;
x_sw = 0;
y_sw = 0.12;

y_origin = (y_off + y_sw)/2;
x_origin = (x_on + x_off)/2;

psi_left = atan((y_off-y_origin)/(x_off-x_origin)) + pi;
psi_right = atan((y_on-y_origin)/(x_on-x_origin));

psi_st = [psi_right,psi_left];
delta_st = [psi_left-psi_right,pi*2-(psi_left-psi_right)];
z_st = polyfit(psi_st, delta_st, 1);

psi_sw = [psi_left,psi_right+pi*2];
delta_sw = [pi*2-(psi_left-psi_right),psi_left-psi_right];
z_sw = polyfit(psi_sw, delta_sw, 1);

x = x0;
A = zeros(2,tmax/h);
a = 1;
for i = 0:h:tmax
    
A(1,a) = x(1);
A(2,a) = x(2);

x1 = rem(x(1),pi*2);
x2 = rem(x(2),pi*2);
if (psi_right<=x1) && (x1<=psi_left)
        delta_psi = polyval(z_st,x1);
elseif x1>psi_left
        delta_psi = polyval(z_sw,x1);
else
        delta_psi =  polyval(z_sw,x1+2*pi);
end

if x1>x2
    x2 = x2+pi*2;
end

x(1) = x(1) + h*(w+A_L*sin((x2-x1)-delta_psi));
x(2) = x(2) + h*(w+A_R*sin(delta_psi-(x2-x1))); 

a = a+1;
end
A(3,:) = linspace(0,tmax,tmax/h+1);
% solve the ode for CPG and plot the states
figure(1)
subplot(2,1,1)
plot(A(3,:) ,A(1,:) ,'LineWidth',2)
hold on;
plot(A(3,:) ,A(2,:) ,'LineWidth',2)
legend('$\theta_L(t)$','$\theta_R(t)$','Interpreter','latex')
title('Time-domain response','Interpreter','latex')
xlabel('Time (s)','Interpreter','latex');
ylabel('$\theta(t)$','Interpreter','latex')
set(gca,'fontsize',14);

subplot(2,1,2)
plot(A(3,:),A(2,:) -A(1,:) ,'LineWidth',2)
xlabel('Time (s)','Interpreter','latex');
ylabel('$\Delta\theta(t)$','Interpreter','latex')
set(gca,'fontsize',14);