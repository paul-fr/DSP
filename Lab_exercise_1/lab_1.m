%% a)
f1 = 200;
f2 = 200.25;
fs = 800;
amp = 1;
N = 1600;

t = 0:1/fs:(N-1)/fs;

sig1 = sin(2*pi*f1*t);
sig2 = sin(2*pi*f2*t);

%% b)
w_rect = ones(N, 1);
w_hann = hann(N,'periodic');
w_ftopw = flattopwin(N,'periodic');

%% c)
% rect
sig1_rect = sig1 .* w_rect';
sig1_rect_fft = fft(sig1_rect);
sig2_rect = sig2 .* w_rect';
sig2_rect_fft = fft(sig2_rect);

% hann
sig1_hann = sig1 .* w_hann';
sig1_hann_fft = fft(sig1_hann);
sig2_hann = sig2 .* w_hann';
sig2_hann_fft = fft(sig2_hann);

% f2w
sig1_ftopw = sig1 .* w_ftopw';
sig1_ftopw_fft = fft(sig1_ftopw);
sig2_ftopw = sig2 .* w_ftopw';
sig2_ftopw_fft = fft(sig2_ftopw);

%% d)
normalizer = 2/N*ones(1,N);
normalizer(1) = 1;
normalizer(N/2) = 1;

f = (0:N-1)./2;

%rect
sig1_rect_fft_log = 20*log10((normalizer.*abs(sig1_rect_fft)));
sig2_rect_fft_log = 20*log10((normalizer.*abs(sig2_rect_fft)));

figure(1);
plot(f(1:N/2+1), sig1_rect_fft_log(1:N/2+1));
hold on;
plot(f(1:N/2+1), sig2_rect_fft_log(1:N/2+1));
grid on;
legend("200 Hz","200.25 Hz");
title("f_s = 800 Hz, rectangular window, FFT length = 1600, ∆f = 0.5 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");

%hann
sig1_hann_fft_log = 20*log10((normalizer.*abs(sig1_hann_fft)));
sig2_hann_fft_log = 20*log10((normalizer.*abs(sig2_hann_fft)));

figure(2);
plot(f(1:N/2+1), sig1_hann_fft_log(1:N/2+1));
hold on;
plot(f(1:N/2+1), sig2_hann_fft_log(1:N/2+1));
grid on;
legend("200 Hz","200.25 Hz");
title("f_s = 800 Hz, Hanning window, FFT length = 1600, ∆f = 0.5 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");

% f2w
sig1_ftopw_fft_log = 20*log10((normalizer.*abs(sig1_ftopw_fft)));
sig2_ftopw_fft_log = 20*log10((normalizer.*abs(sig2_ftopw_fft)));

figure(3);
plot(f(1:N/2+1), sig1_ftopw_fft_log(1:N/2+1));
hold on;
plot(f(1:N/2+1), sig2_ftopw_fft_log(1:N/2+1));
grid on;
legend("200 Hz","200.25 Hz");
title("f_s = 800 Hz, flat top window, FFT length = 1600, ∆f = 0.5 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");

%% e)
normalizer2 = 1/N*ones(1,2*N);
normalizer2(1) = 1;
normalizer2(N) = 1;

n2 = 2*N;

f = (0:(n2)-1)./4;

%rect
sig1_rect_pad = [sig1_rect, zeros(1,N)];
sig1_rect_pad_fft = normalizer2.*fft(sig1_rect_pad);
sig1_rect_pad_fft_norm_log = 20*log10(abs(sig1_rect_pad_fft./max(sig1_rect_pad_fft)));

sig2_rect_pad = [sig2_rect, zeros(1,N)];
sig2_rect_pad_fft = normalizer2.*fft(sig2_rect_pad);
sig2_rect_pad_fft_norm_log = 20*log10(abs(sig2_rect_pad_fft./max(sig2_rect_pad_fft)));


figure(4);
subplot(2,1,1);
plot(f(1:n2/2+1), sig1_rect_pad_fft_norm_log(1:n2/2+1))
title("f = 200 Hz, f_s = 800 Hz, rectangular window, FFT length = 3200, ∆f = 0.25 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");
subplot(2,1,2);
plot(f(1:n2/2+1), sig2_rect_pad_fft_norm_log(1:n2/2+1))
title("f = 200 Hz, f_s = 800 Hz, flat top window, FFT length = 3200, ∆f = 0.25 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");
%hann
sig1_hann_pad = [sig1_hann, zeros(1,N)];
sig1_hann_pad_fft = normalizer2.*fft(sig1_hann_pad);
sig1_hann_pad_fft_norm_log = 20*log10(abs(sig1_hann_pad_fft./max(sig1_hann_pad_fft)));

sig2_hann_pad = [sig2_hann, zeros(1,N)];
sig2_hann_pad_fft = normalizer2.*fft(sig2_hann_pad);
sig2_hann_pad_fft_norm_log = 20*log10(abs(sig2_hann_pad_fft./max(sig2_hann_pad_fft)));


figure(5);
subplot(2,1,1);
plot(f(1:n2/2+1), sig1_hann_pad_fft_norm_log(1:n2/2+1))
title("f = 200 Hz, f_s = 800 Hz, Hanning window, FFT length = 3200, ∆f = 0.25 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");
subplot(2,1,2);
plot(f(1:n2/2+1), sig2_hann_pad_fft_norm_log(1:n2/2+1))
title("f = 200.25 Hz, f_s = 800 Hz, Hanning window, FFT length = 3200, ∆f = 0.25 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");

%ftopw
sig1_ftopw_pad = [sig1_ftopw, zeros(1,N)];
sig1_ftopw_pad_fft = normalizer2.*fft(sig1_ftopw_pad);
sig1_ftopw_pad_fft_norm_log = 20*log10(abs(sig1_ftopw_pad_fft./max(sig1_ftopw_pad_fft)));

sig2_ftopw_pad = [sig2_ftopw, zeros(1,N)];
sig2_ftopw_pad_fft = normalizer2.*fft(sig2_ftopw_pad);
sig2_ftopw_pad_fft_norm_log = 20*log10(abs(sig2_ftopw_pad_fft./max(sig2_ftopw_pad_fft)));

figure(6);
subplot(2,1,1);
plot(f(1:n2/2+1), sig1_ftopw_pad_fft_norm_log(1:n2/2+1))
title("f = 200 Hz, f_s = 800 Hz, flat top window, FFT length = 3200, ∆f = 0.25 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");
subplot(2,1,2);
plot(f(1:n2/2+1), sig2_ftopw_pad_fft_norm_log(1:n2/2+1))
title("f = 200.25 Hz, f_s = 800 Hz, flat top window, FFT length = 3200, ∆f = 0.25 Hz");
xlabel("f / Hz");
ylabel("20 \cdot log_{10}(2/N \cdot |A|)");