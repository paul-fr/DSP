%c) 

[h100,hw100] = gen_highpass(100,4*100);
[h1k,hw1k] = gen_highpass(1000,4*1000);
[h10k,hw10k] = gen_highpass(10000,4*10000);

stem(h10k)

padh100= zeros(1,10000)
padh100(1:401)= h100;


semilogx(20*log10(abs(fft(padh100))))
%plot doesn't look right, zero padding?