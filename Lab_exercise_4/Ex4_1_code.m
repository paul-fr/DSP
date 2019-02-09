%% 
%c)

fs = 48000;
fc = [100; 1000; 10000];
%determine length of FIR
hl = 4* ceil(fs./fc);

[h100,hw100] = gen_highpass(fc(1),hl(1));
[h1k,hw1k] = gen_highpass(fc(2),hl(2));
[h10k,hw10k] = gen_highpass(fc(3),hl(3));




%pad all impulse responses to equal length for plotting and calculate fft 
padl= 20*hl(1);
pad = zeros(1,padl);
f=0:24000/(padl/2):24000;

padh100=pad;
padh100(1:hl(1)+1)=h100;
fh100 = fft(padh100);

padhw100=pad;
padhw100(1:hl(1)+1)=hw100;
fhw100 = fft(padhw100);

padh1k=pad;
padh1k(1:hl(2)+1)=h1k;
fh1k = fft(padh1k);

padhw1k=pad;
padhw1k(1:hl(2)+1)=hw1k;
fhw1k = fft(padhw1k);

padh10k=pad;
padh10k(1:hl(3)+1)=h10k;
fh10k = fft(padh10k);

padhw10k=pad;
padhw10k(1:hl(3)+1)=hw10k;
fhw10k = fft(padhw10k);

%collect spectra for easier plotting 
fh=[fh100; fh1k; fh10k];
fhw= [fhw100; fhw1k; fhw10k];

%halved spectrum for plotting
pfh=fh(:,1:padl/2+1);
pfhw=fhw(:,1:padl/2+1);
%amplitude spectrum
pspech = 20*log10(abs(pfh));
pspechw = 20*log10(abs(pfhw));

%phase spectrum
phases =    [
            phase(pfh(1,:));
            phase(pfh(2,:));
            phase(pfh(3,:));
            phase(pfhw(1,:));
            phase(pfhw(2,:));
            phase(pfhw(3,:));
            ];


%magnitude plot including constant line at -36 dB
figure()
semilogx(f,pspechw, 'LineWidth', 2)
hold on
set(gca,'ColorOrderIndex',1)
semilogx(f,pspech)
semilogx(f,-36*ones(1,padl/2+1),'k')
grid on
ylim([-60 6])
legend("KB 100Hz","KB 1000Hz","KB 10kHz","RECT 100Hz","RECT 10Hz","RECT 10kHz")
title('Windowed FIR HP')
xlabel('f/Hz')
ylabel('A/dB')


%check linear phase
figure()
plot(f,phases)
legend("KB 100Hz","KB 1000Hz","KB 10kHz","RECT 100Hz","RECT 10Hz","RECT 10kHz")
title('Windowed FIR Phase')
xlabel('f/Hz')
ylabel('Phase/rad')

%--> the FIR filters are linear phase

%d) for A < 21 the definition of the Kaiser-Bessel is identical with that
%of the rectangular window.


%%
%e)

fs = 48000;
fc = [100; 1000; 10000];
N=192;

[h100,hw100] = gen_highpass(fc(1),N);
[h1k,hw1k] = gen_highpass(fc(2),N);
[h10k,hw10k] = gen_highpass(fc(3),N);




%pad all impulse responses to equal length for plotting and calculate fft 
padl= 20*hl(1);
pad = zeros(1,padl);
f=0:24000/(padl/2):24000;

padh100=pad;
padh100(1:N+1)=h100;
fh100 = fft(padh100);

padhw100=pad;
padhw100(1:N+1)=hw100;
fhw100 = fft(padhw100);

padh1k=pad;
padh1k(1:N+1)=h1k;
fh1k = fft(padh1k);

padhw1k=pad;
padhw1k(1:N+1)=hw1k;
fhw1k = fft(padhw1k);

padh10k=pad;
padh10k(1:N+1)=h10k;
fh10k = fft(padh10k);

padhw10k=pad;
padhw10k(1:N+1)=hw10k;
fhw10k = fft(padhw10k);

%collect spectra for easier plotting 
fh=[fh100; fh1k; fh10k];
fhw= [fhw100; fhw1k; fhw10k];

%halved spectrum for plotting
pfh=fh(:,1:padl/2+1);
pfhw=fhw(:,1:padl/2+1);
%amplitude spectrum
pspech = 20*log10(abs(pfh));
pspechw = 20*log10(abs(pfhw));

%magnitude plot including constant line at -36 dB
figure()
semilogx(f,pspechw, 'LineWidth', 2)
hold on
set(gca,'ColorOrderIndex',1)
semilogx(f,pspech)
semilogx(f,-36*ones(1,padl/2+1),'k')
grid on
ylim([-60 6])
legend("KB 100Hz","KB 1000Hz","KB 10kHz","RECT 100Hz","RECT 10Hz","RECT 10kHz")
title('Windowed FIR HP with constant N=192')
xlabel('f/Hz')
ylabel('A/dB')



