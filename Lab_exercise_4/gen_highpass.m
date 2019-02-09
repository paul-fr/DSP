function [h,hw] = gen_highpass(fc,N)
%GEN_LOWPASS generates impulse responses of FIR lowpass filter with rectangular and kaiser-bessel windowing for
%exercise 4.1


%initialize values
fs = 48000;
Wc = 2*pi*fc/fs;
k = 0:N;

%generate impulse response of FIR filter


h= - sin(Wc.*(k - N/2)) ./ (pi *(k - N/2 ));
h(N/2 + 1) = 1 - Wc/pi;





%generate Kaiser-bessel window
A=36;
beta = 0.5842* (A - 21)^(0.4) + 0.07886 * (A -21);
w= kaiser(N+1,beta)';

%apply window to function
hw = h .* w;
end

