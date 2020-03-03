function dxdt = NLS(t,x)
dxdt = [10+100*sin(x(2)-x(1));
        10+100*sin(x(1)-x(2))]; 
return