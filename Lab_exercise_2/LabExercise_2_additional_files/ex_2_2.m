[Signal fs] = audioread('Emphasis_FFT18_48K.wav');

N = length(Signal);
df = fs/N;
f_axis = -fs/2+df:df:fs/2;
dt = 1/fs;
t_axis = 0:dt:dt*(N-dt);

%Werte der Achsen m√ºssen aufgrund eines kuriosen Fehlers angepasst werden    
f_st = length(f_axis)/2;
f_sp = length(f_axis);

xi = [Signal, Signal];

if 1 
  [xosys,xo] = sys(xi,fs);
end

Xosys = fftshift(fft(xosys));
Xo = fftshift(fft(xo));
Xi = fftshift(fft(xi));

G_osys = Xosys./Xi;
g_osys = ifft(fftshift(G_osys));
G_o = Xo./Xosys; 
g_o = ifft(fftshift(G_o));

%Phase unwrapping and group delay calculation
arg_G_osys_1 = angle(G_osys(:,1)); %arg in octave is angle in matlab
arg_G_osys_2 = angle(G_osys(:,2));

arg_G_o_1 = angle(G_o(:,1));
arg_G_o_2 = angle(G_o(:,2));

%hier gabs einen Fehler, so dass statt 'end' die L√§nge eingegeben werden musste
arg_G_osys_1 = arg_G_osys_1(length(arg_G_osys_1)/2:length(arg_G_osys_1));
arg_G_osys_2 = arg_G_osys_2(length(arg_G_osys_2)/2:length(arg_G_osys_2));

arg_G_o_1 = arg_G_o_1(length(arg_G_o_1)/2:length(arg_G_o_1));
arg_G_o_2 = arg_G_o_2(length(arg_G_o_2)/2:length(arg_G_o_2));


arg_G_osys_1 = unwrap(arg_G_osys_1);
arg_G_osys_2 = unwrap(arg_G_osys_2);
arg_G_o_1 = unwrap(arg_G_o_1);
arg_G_o_2 = unwrap(arg_G_o_2);

grpdelay_G_osys_1 = diff(arg_G_osys_1)./(df*2*pi);
grpdelay_G_osys_2 = diff(arg_G_osys_2)./(df*2*pi);
grpdelay_G_o_1 = diff(arg_G_o_1)./(df*2*pi);
grpdelay_G_o_2 = diff(arg_G_o_2)./(df*2*pi);

if 0 %Darstellung der Spektren
  figure(1);
  plot(f_axis,20*log10(abs(Xi)));
  title('Betragsspektrum von X_i');
  ylabel('|Xi(f)|');
  xlabel('f / Hz');
  
  figure(2);
  plot(f_axis,20*log10(abs(Xo)));
  title('Betragsspektrum von X_o');
  ylabel('|Xo(f)|');
  xlabel('f / Hz');
  
  figure(3);
  plot(f_axis,20*log10(abs(Xosys)));
  title('Betragsspektrum von X_{osys}');
  ylabel('|Xosys(f)|');
  xlabel('f / Hz');
end

if 0  %Darstellung der √úbertragungsfunktionen
  %%
  figure('name','‹bertragungsfunktion des Messsystems');
  
  subplot(2,1,1);
  semilogx(f_axis(f_st-1:f_sp),20*log10(abs(G_osys(f_st-1:f_sp,:))));
  title('Betrag');
  ylabel('|Gosys(f)|');
  xlabel('f / Hz');
  legend('Kanal 1','Kanal 2');
  
  subplot(2,1,2);
  semilogx(f_axis(f_st:f_sp),arg_G_osys_1);
  hold on;
  semilogx(f_axis(f_st:f_sp),arg_G_osys_2);
  title('Phase');
  ylabel('arg(Gosys(f))');
  xlabel('f / Hz');
  legend('Kanal 1','Kanal 2');

  %%
  figure('name','‹bertragungsfunktion des DUT');
  
  subplot(2,1,1);
  semilogx(f_axis(f_st:f_sp),20*log10(abs(G_o(f_st:f_sp,:))));
  title('Betrag');
  ylabel('|Go(f)|');
  xlabel('f / Hz'); 
 
  subplot(2,1,2);  
  semilogx(f_axis(f_st:f_sp),angle(G_o(f_st:f_sp,1)));
  hold on;
  semilogx(f_axis(f_st:f_sp),arg_G_o_2);
  title('Phase');
  ylabel('arg(Gosys(f))');
  xlabel('f / Hz');
end

if 0  %Darstellung der Impulsantworten
  figure(6);
  plot(t_axis,g_osys);
  xlim([0 0.0006]);
  xlabel('t / s');
  title('Impulsantwort Messsystem');
  legend('Kanal 1','Kanal 2');
  
  figure(7);
  plot(t_axis,g_o);
  xlim([0 0.0015]);
  xlabel('t / s');
  title('Impulsantwort DUT');
  legend('Kanal 1','Kanal 2');
end

if 0 %Darstellung der Gruppenlaufzeit der Systeme
  figure(8);
  plot(f_axis(f_st:f_sp-1),grpdelay_G_osys_1,'b');
  hold on;
  plot(f_axis(f_st:f_sp-1),grpdelay_G_osys_2,'r');
  ylabel('\tau_{g} / s');
  xlabel('f / Hz');
  title('Gruppenlaufzeit Messsystem');
  
  figure(9);
  plot(f_axis(f_st:f_sp-1),grpdelay_G_o_1,'b');
  hold on;
  plot(f_axis(f_st:f_sp-1),grpdelay_G_o_2,'r');
  ylabel('\tau_{g} / s');
  xlabel('f / Hz');
  title('Gruppenlaufzeit DUT');
end