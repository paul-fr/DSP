 
 
 f1=200;
 f2=200.25;
 fs=800;
 N=1600;
 k=0:(N-1);
 t=k/fs;
 f=k/2;
 
 
 %%
 %aufgabe a)
 sig1=sin(2*pi*f1*t);
 sig2=sin(2*pi*f2*t);
 
 
 %%
 %aufgabe b)
 rect = ones(N,1);
 hanning = hann(N,'periodic');
 flat = flattopwin(N,'periodic');

 %%
 %c)
 
 %rect
 sig1_rect_fft = fft(sig1);
 sig2_rect_fft = fft(sig2);
 
 %hann
 sig1_hann = sig1 .* hanning';
 sig1_hann_fft = fft(sig1_hann);
 sig2_hann = sig2 .* hanning';
 sig2_hann_fft = fft(sig2_hann);
 
 %flattop
 sig1_flat = sig1 .* flat';
 sig1_flat_fft = fft(sig1_flat);
 sig2_flat = sig2 .* flat';
 sig2_flat_fft = fft(sig2_flat);
 
 
 %%
 %SECT d)
 %normalise
 normalise= 2/N*ones(1,N);
 normalise(1)= 1;
 normalise(N/2 + 1);
 %%%
 figure(1);
 hold on;
 plot(f(1:N/2+1),20*log10(abs(sig1_rect_fft(1:N/2+1))));
 plot(f(1:N/2+1),20*log10(abs(sig2_rect_fft(1:N/2+1))));
 legend('200 Hz','200.25 Hz');
 title('fs = 800 Hz, rectangular window, FFT length = 1600, \Deltaf = 0.5 Hz');
 xlabel('f/Hz');
 ylabel('20*log10(|A|*2/N /dB)');
 
 figure(2);
 hold on;
 plot(f(1:N/2+1),20*log10(abs(sig1_hann_fft(1:N/2+1))));
 plot(f(1:N/2+1),20*log10(abs(sig2_hann_fft(1:N/2+1))));
 legend('200 Hz','200.25 Hz');
 title('fs = 800 Hz, rectangular window, FFT length = 1600, \Deltaf = 0.5 Hz');
  xlabel('f/Hz');
 ylabel('20*log10(|A|*2/N /dB)');
 
 figure(3);
 hold on;
 plot(f(1:N/2+1),20*log10(abs(sig1_flat_fft(1:N/2+1))));
 plot(f(1:N/2+1),20*log10(abs(sig2_flat_fft(1:N/2+1))));
 legend('200 Hz','200.25 Hz');
 title('fs = 800 Hz, flattop window, FFT length = 1600, \Deltaf = 0.5 Hz');
 xlabel('f/Hz');
 ylabel('20*log10(|A|*2/N /dB)');
 
 %%aufgabe e)
 padf=50;
 Np = padf*N;
 fpad = (0:Np/2)./(2*padf);
 pad_norm= 2/(Np)*ones(1,Np);
 %pad_norm(1)= 1;
 %pad_norm(Np/2 + 1 )= 1;
 
 %rect
 sig1_rect_pad = [sig1 zeros(1,Np-N)];
 sig1_rect_pad_fft = pad_norm.*fft(sig1_rect_pad);
 sig1_rect_spec = 20*log10(abs(sig1_rect_pad_fft(1:Np/2+1))/max(abs(sig1_rect_pad_fft)));
 sig2_rect_pad = [sig2 zeros(1,Np-N)];
 sig2_rect_pad_fft = pad_norm.*fft(sig2_rect_pad);
 sig2_rect_spec = 20*log10(abs(sig2_rect_pad_fft(1:Np/2+1))/max(abs(sig2_rect_pad_fft)));
 
 figure();
  subplot(2,1,1);
   plot(fpad,sig1_rect_spec);
   title(['f = 200 Hz, fs = 800 Hz, rectangular window, FFT length = ' ,num2str(Np),', \Deltaf = ', num2str(fs/Np) ,' Hz']);
   xlabel('f/Hz');
  subplot(2,1,2);
   plot(fpad,sig2_rect_spec);
   title(['f = 200.25 Hz, fs = 800 Hz, rectangular window, FFT length = ' ,num2str(Np),', \Deltaf = ', num2str(fs/Np) ,' Hz']);
   xlabel('f/Hz');
   
 %hanning
 sig1_hann_pad = [sig1_hann zeros(1,Np-N)];
 sig1_hann_pad_fft = pad_norm.*fft(sig1_hann_pad);
 sig1_hann_spec = 20*log10(abs(sig1_hann_pad_fft(1:Np/2+1))/max(abs(sig1_hann_pad_fft)));
 sig2_hann_pad = [sig2_hann zeros(1,Np-N)];
 sig2_hann_pad_fft = pad_norm.*fft(sig2_hann_pad);
 sig2_hann_spec = 20*log10(abs(sig2_hann_pad_fft(1:Np/2+1))/max(abs(sig2_hann_pad_fft)));
 
  figure();
  subplot(2,1,1);
   plot(fpad, sig1_hann_spec);
   title(['f = 200 Hz, fs = 800 Hz, hanning window, FFT length = ' ,num2str(Np),', \Deltaf = ', num2str(fs/Np) ,' Hz']);
   xlabel('f/Hz');
  subplot(2,1,2);
   plot(fpad, sig2_hann_spec);
   title(['f = 200.25 Hz, fs = 800 Hz, hanning window, FFT length = ' ,num2str(Np),', \Deltaf = ', num2str(fs/Np) ,' Hz']);
   xlabel('f/Hz');
   
 
 %flattop
 sig1_flat_pad = [sig1_flat zeros(1,Np-N)];
 sig1_flat_pad_fft = pad_norm.*fft(sig1_flat_pad);
 sig1_flat_spec = 20*log10(abs(sig1_flat_pad_fft(1:Np/2+1))/max(abs(sig1_flat_pad_fft)));
 sig2_flat_pad = [sig2_flat zeros(1,Np-N)];
 sig2_flat_pad_fft = pad_norm.*fft(sig2_flat_pad);
 sig2_flat_spec = 20*log10(abs(sig2_flat_pad_fft(1:Np/2+1))/max(abs(sig2_flat_pad_fft)));
 
  figure();
  subplot(2,1,1);
   plot(fpad,sig1_flat_spec);
   title(['f = 200 Hz, fs = 800 Hz, flattop window, FFT length = ' ,num2str(Np),', \Deltaf = ', num2str(fs/Np) ,' Hz']);
   xlabel('f/Hz');
  subplot(2,1,2);
   plot(fpad,sig2_flat_spec);
   title(['f = 200.25 Hz, fs = 800 Hz, flattop window, FFT length = ' ,num2str(Np),', \Deltaf = ', num2str(fs/Np) ,' Hz']);
   xlabel('f/Hz');
   
 %%
 %aufg g
 
 
 %bandwiwdth
  %rect
  spec = sig1_rect_spec;
  
  [~, middle] = max(spec);
  [~,left] = min(abs(spec(1:middle)+3));
  [~,right] = min(abs(spec(middle:Np/2)+3));
  right = right + middle;
  bandw_sig1_rect = fpad(right) - fpad(left)
  
  spec = sig2_rect_spec;
  
  [~, middle] = max(spec);
  [~,left] = min(abs(spec(1:middle)+3));
  [~,right] = min(abs(spec(middle:Np/2)+3));
  right = right + middle;
  bandw_sig2_rect = fpad(right) - fpad(left)
  
  %hann  
  spec = sig1_hann_spec;
  
  [~, middle] = max(spec);
  [~,left] = min(abs(spec(1:middle)+3));
  [~,right] = min(abs(spec(middle:Np/2)+3));
  right = right + middle;
  bandw_sig1_hann = fpad(right) - fpad(left)
  
  spec = sig2_hann_spec;
  
  [~, middle] = max(spec);
  [~,left] = min(abs(spec(1:middle)+3));
  [~,right] = min(abs(spec(middle:Np/2)+3));
  right = right + middle;
  bandw_sig2_hann = fpad(right) - fpad(left)

  %flat
  
  spec = sig1_flat_spec;
  
  [~, middle] = max(spec);
  [~,left] = min(abs(spec(1:middle)+3));
  [~,right] = min(abs(spec(middle:Np/2)+3));
  right = right + middle;
  bandw_sig1_flat = fpad(right) - fpad(left)
  
  spec = sig2_flat_spec;
  
  [~, middle] = max(spec);
  [~,left] = min(abs(spec(1:middle)+3));
  [~,right] = min(abs(spec(middle:Np/2)+3));
  right = right + middle;
  bandw_sig2_flat = fpad(right) - fpad(left)