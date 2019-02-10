%% a) sine
fs=48000; % sample frequency
N=96001; % sample points
n=0:N-1;
t=n/fs;

f0=1000; % signal frequency
sn =sin(2*pi*f0*t);

df = fs/N;
df_axis = 1 : df : fs/2;

%% b) white noise
wn = wgn(1, N, 0);

%% c) pink noise
WN = fft(wn);   % fft

NumUniquePts  = (N+1)/2 +1;
k = 1:NumUniquePts; 
PNAmpl = WN./sqrt(N);   %normalise

PN = PNAmpl.*WN;
pn = ifft(PN);

%% d) mean
mean_sn = mean(sn);
mean_wn = mean(wn);
mean_pn = mean(pn);

fprintf('\nMean of sine: %d\n', mean_sn);
fprintf('Mean of white noise: %d\n', mean_wn);
fprintf('Mean of pink noise: %d\n\n', mean_pn);

%% e) rms
sn_dBrms = 20*log10( rms(sn) );
wn_dBrms = 20*log10( rms(wn) );
pn_dBrms = 20*log10( rms(pn) );

%% f) peaks
%peaks
sn_dBpeak = 20*log10( max(sn) );
wn_dBpeak = 20*log10( max(wn) );
pn_dBpeak = 20*log10( max(pn) );

fprintf('Peak value of sine: %d dBu_peak\n', sn_dBpeak);
fprintf('Peak value of white noise: %d dBu_peak\n', wn_dBpeak);
fprintf('Peak value of pink noise: %d dBu_peak\n\n', pn_dBpeak);

%creast factor
sn_CrestdB = sn_dBpeak - sn_dBrms;
wn_CrestdB = wn_dBpeak - wn_dBrms;
pn_CrestdB = pn_dBpeak - pn_dBrms;

fprintf('Crest factor of sine: %d dB\n', sn_CrestdB);
fprintf('Crest factor of white noise: %d dB\n', wn_CrestdB);
fprintf('Crest factor of pink noise: %d dB\n', pn_CrestdB);

%% g) FFT analyser
%fft

SN_fft = fft(sn,N); % fft
SN_fft = abs(SN_fft).*(2/N); % normalise
SN_fft = 20*log10(SN_fft); % dB

WN_fft = fft(wn);
WN_fft = abs(WN_fft).*(2/N);
WN_fft = 20*log10(WN_fft);

PN_fft = fft(pn);
PN_fft = abs(PN_fft).*(2/N);
PN_fft = 20*log10(PN_fft);

%plot
figure(1);
hold on;
plot(df_axis, PN_fft(1:length(df_axis)), 'r');
title('FFT analyser');
plot(df_axis, WN_fft(1:length(df_axis)), 'color', [0.75, 0.75, 0]);
plot(df_axis, SN_fft(1:length(df_axis)), 'b');
set(gca, 'XScale', 'log');
xlim([2, fs/2+1]);
xlabel('frequency / kHz')
ylabel('amplitude / dB')
legend('pink noise', 'white noise', 'sine');

%% h) Real-time analyser
% generate frequencies
f_band = zeros(3,9);
f_band(1,1) = 44.194; % start lower corner frequency
f_band(2,1) = 62.5; % start centre frequency

for idx = 1:9
    f_band(3,idx) = 2*f_band(1,idx); % higher corner frequencies
    if idx < 9
        f_band(2,idx+1) = 2*f_band(2,idx); % centre frequencies
        f_band(1,idx+1) = f_band(3,idx); % lower corner frequencies
    end
end

% N_1 / N_2
N_1 = zeros(1,9);
N_2 = zeros(1,9);

for idx_freq = 1:length(df_axis)
    if df_axis(idx_freq) >= f_band(1,1)
        N_1(1) = idx_freq;
        break;
    end
end
for idx = 1:9
    for idx_freq = 1:length(df_axis)
        if df_axis(idx_freq) <= f_band(3,idx)
            N_2(idx) = idx_freq;
        end
    end
    if idx < 9
        N_1(idx+1) = N_2(idx)+1;
    end
end

% calculate
SN_rta = zeros(1, 9);
WN_rta = zeros(1, 9);
PN_rta = zeros(1, 9);

for idx = 1:9
    for n = N_1(idx):N_2(idx)
        SN_rta(idx) = sqrt(abs((2/n)*SN_fft(n))^2)+SN_rta(idx);
        WN_rta(idx) = sqrt(abs((2/n)*WN_fft(n))^2)+WN_rta(idx);
        PN_rta(idx) = sqrt(abs((2/n)*PN_fft(n))^2)+PN_rta(idx);
    end
    SN_rta(idx) = 20*log10(SN_rta(idx));
    WN_rta(idx) = 20*log10(WN_rta(idx));
    PN_rta(idx) = 20*log10(PN_rta(idx));
end

figure(2);
hold on;
bar(SN_rta, 'b');
bar(PN_rta, 'r');
bar(WN_rta, 'FaceColor', [0.75, 0.75, 0]);
set(gca, 'XTickLabel', {f_band(2,:)})
xlim([0.5 9.5])
title('Real-time analyser');
xlabel('centre frequency / Hz')
ylabel('peak / dB')
legend('sine', 'pink noise', 'white noise');