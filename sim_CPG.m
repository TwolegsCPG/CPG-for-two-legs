tmax = 0.5; % maximal time for ode solution
x0=[0.5*pi;0];

% solve the ode for CPG and plot the states
[t0,y0]=ode45(@CPG,[0,tmax],x0);
figure(1)
plot(t0,y0,'LineWidth',2)
legend('$\theta(t)$','$\dot \theta(t)$','Interpreter','latex')
title('Time-domain response')
xlabel('Time (s)','Interpreter','latex');
ylabel('State values (units, units/sec)','Interpreter','latex')
figure(2)
plot(y0(:,1),y0(:,2),'LineWidth',2)
title('Phase-plane portrait')
xlabel('$\theta(t)$','Interpreter','latex')
ylabel('$\dot \theta(t)$','Interpreter','latex')

%% Limit cycle
[x,y] = meshgrid(-pi:0.1:pi,-pi:0.1:pi);
dx = 10+100*sin(y-x);
dy = 10+100*sin(x-y);
figure(3); 
quiver(x, y, dx, dy); 
streamline(x,y, dx, dy, 0.5*pi,0);