% a) difference equations
% system 1: y[k] = x[k] + d[k] + e[k] - 2*e[k-1] + e[k-2]
% system 2: y[k] = x[k] + d[k] - 2*d[k-1] + d[k-2] + e[k] - 2*e[k-1] + e[k-2]
% 
% b) signal and noise transfer functions are identical for both systems 
%    signal transfer function: Hx(z) = 1
%    noise transfer function: He(z) = (z-1)^2/z^2 = (1-z^(-1))^2  
%    
% c) abs( (1-exp(-i*w))^2 )
%  
% 
% d) visualize system transfer function
N=1000;
w=0:pi/N:pi;

He=abs((1-exp(-1i*w)).^2);
plot(w,He)

%the system lowers noise power at low frequencies and increases noise power
%at higher frequencies

%e) the second system appears more sensible because it shapes the dither
%noise as well

% 
