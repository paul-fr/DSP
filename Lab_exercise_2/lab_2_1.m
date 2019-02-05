%% a) Sine
f = 1000;
fs = 48000;
amp = 1;
N = 96001;

t = 0:1/fs:(N-1)/fs;

sn = amp * sin(2*pi*f*t);

%% b) white noise
wn = wgn(1, N, 0);

%% c) pink noise
WN = fft(wn);

NumUniquePts  = (N+1)/2 +1;
k = 1:NumUniquePts;
PNAmpl = WN./sqrt(N);

PN = PNAmpl.*WN;
pn = ifft(PN);

%% d) mean
mean_sn = mean(sn);
mean_wn = mean(wn);
mean_ps = mean(pn);