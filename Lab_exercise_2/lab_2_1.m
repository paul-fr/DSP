%% a) sine
f = 1000;
fs = 48000;
amp = 1;
N = 96001;

t = 0:1/fs:(N-1)/fs;
sn = amp * sin(2*pi*f*t);

% figure(1);
% plot(sn);
% title('sine');

%% b) white noise
wn = wgn(1, N, 0);

% figure(2);
% plot(wn, 'r');
% title('white noise');

%% c) pink noise
WN = fft(wn);

NumUniquePts  = (N+1)/2 +1;
k = 1:NumUniquePts;
PNAmpl = WN./sqrt(N);

PN = PNAmpl.*WN;
pn = ifft(PN);

% figure(3);
% plot(pn,'m');
% title('pink noise');

%% d) mean
mean_sn = mean(sn);
mean_wn = mean(wn);
mean_pn = mean(pn);

fprintf('\nmean of sine: %d\n', mean_sn);
fprintf('mean of white noise: %d\n', mean_wn);
fprintf('mean of pink noise: %d\n', mean_pn);

%% e) rms
sn_dBrms = 20*log10( rms(sn) );
wn_dBrms = 20*log10( rms(wn) );
pn_dBrms = 20*log10( rms(pn) );

%% f) peaks
%peaks
sn_dBpeak = 20*log10( max(sn) );
wn_dBpeak = 20*log10( max(wn) );
pn_dBpeak = 20*log10( max(pn) );

%creast factor
sn_CrestdB = sn_dBpeak - sn_dBrms;
wn_CrestdB = wn_dBpeak - wn_dBrms;
pn_CrestdB = pn_dBpeak - pn_dBrms;
