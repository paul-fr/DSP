function x_quant = my_quant(x,N)
%MY_QUANT Summary of this function goes here
%   Detailed explanation goes here
x_in = x; 

idx = find(abs(x_in) > 1);
x_in(idx) =  sign(x_in(idx));

if mod(N,2) == 0
   Q = 2/N;
   x_quant= Q * floor(x_in/Q + 1/2);
   iqdx = find(x > 1-Q);
   x_quant(iqdx) = 1-Q;
end

if mod(N,2) ~= 0 
   Q = 2/(N-1);
   x_quant= Q * floor(x_in/Q + 1/2);    
end    
end

