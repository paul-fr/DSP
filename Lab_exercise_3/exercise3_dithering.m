%a) initialize values and generate sine
Q=0.25;
fsin=960;
fs=48000;
N=50000;
k=0:(N-1);
x=Q*sin(2*pi*fsin*k/fs);

%b) generate rectangular dither noise
drect=Q/2 * (2*rand(1,N)-1);

figure(1)
subplot(2,1,1)
histogram(drect)
title('Rectangular noise')

%c) generate triangular dither noise

trid = makedist('Triangular','a',-Q,'b',0,'c',Q);
dtri=random(trid,1,N);

subplot(2,1,2)
histogram(dtri)
title('Triangular noise')
%d) add noise to signal
xNODITH=x;
xRECT=x+drect;
xTRI=x+dtri;

%e) quantise signals
xqNODITH = my_quant(xNODITH,8);
eNODITH = xqNODITH - x;

xqRECT = my_quant(xRECT,8);
eRECT = xqRECT - x; 

xqTRI = my_quant(xTRI,8);
eTRI = xqTRI - x;

%f) plot signals

% x axis for plots
pk=1:150; 

figure(2)
subplot(3,1,1)
plot(pk,xNODITH(pk),pk,xqNODITH(pk),pk,eNODITH(pk),pk,Q*ones(1,max(pk)))
title('Signal without dither')
legend('x[k]','xq[k]','e[k]','Q')
ylim([-0.5 0.5])
grid on
grid minor

subplot(3,1,2)
plot(pk,xRECT(pk),pk,xqRECT(pk),pk,eRECT(pk),pk,Q*ones(1,max(pk)))
title('Signal with rectangular dither')
ylim([-0.5 0.5])
grid on
grid minor

subplot(3,1,3)
plot(pk,xTRI(pk),pk,xqTRI(pk),pk,eTRI(pk),pk,Q*ones(1,max(pk)))
title('Signal with triangular dither')
ylim([-0.5 0.5])
grid on
grid minor

%error for non-dithered case strongly depends on the signal, and has the
%same periodicity as the sine
%for dithered signal, error appears more random


%g)write signals to .wav
audiowrite('xNODITH.wav',xNODITH,fs,'BitsPerSample',32);
audiowrite('xqNODITH.wav',xqNODITH,fs,'BitsPerSample',32);
audiowrite('eNODITH.wav',eNODITH,fs,'BitsPerSample',32);


audiowrite('xRECT.wav',xRECT,fs,'BitsPerSample',32);
audiowrite('xqRECT.wav',xqRECT,fs,'BitsPerSample',32);
audiowrite('eRECT.wav',eRECT,fs,'BitsPerSample',32);

audiowrite('xTRI.wav',xTRI,fs,'BitsPerSample',32)
audiowrite('xqTRI.wav',xqTRI,fs,'BitsPerSample',32)
audiowrite('eTRI.wav',eTRI,fs,'BitsPerSample',32)

% quantisation error for dithered signals sounds like noise
% for non-dithered signal the error sounds like a sine

%h) rerunning with Q/8 as signal amplitude yield constant 0 without
%dithering but still audible signal when using triangular or rectangular
%dither
