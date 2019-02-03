%a) initialize values and generate sine
Q=0.25;
fsin=960;
fs=48000;
N=50000;
k=0:(N-1);
x=Q*sin(2*pi*fsin*k/fs);

%b) generate rectangular dither noise
drect=zeros(N);
drect(1:N)=rand