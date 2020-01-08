% https://zhuanlan.zhihu.com/p/57902993
[x,fs]=audioread('record.m4a'); %打开语音信号
sound(x,fs); %播放语音信号
N=length(x); %长度
n=0:N-1;
w=2*n*pi/N;
y1=fft(x); %对原始信号做FFT变换
figure(1); subplot(2,1,1);
plot(n,x) %做原始语音信号的时域波形图
title('原始语音信号时域图');
xlabel('时间t');
ylabel('幅值');
subplot(2,1,2); %做原始语音信号的频谱图
plot(w/pi,abs(y1));
title('原始语音信号频谱')
xlabel('频率Hz');
ylabel('幅度');

% 滤波器设计->双线性变换法设计一个数字低通滤波器对原始语音信号进行滤波处理
fp=800; fs=1300; rs=35; rp=0.5; Fs=44100;
wp=2*Fs*tan(2*pi*fp/(2*Fs));
ws=2*Fs*tan(2*pi*fs/(2*Fs));
% wp=4000*pi; ws=12000*pi; rp=1; rs=30;  % 一组可用值
[n,wn]=buttord(wp, ws, rp, rs, 's');
[b,a]=butter(n, wn, 's');
[num,den]=bilinear(b,a,Fs);         % for analog-to-digital filter conversion
figure(2); subplot(2, 2, 1);
[h,w]=freqz(num,den,512,Fs);
plot(w,abs(h));
xlabel('频率/Hz');ylabel('幅值');
title('巴特沃斯低通滤波器幅度特性');
axis([0,5000,0,1.2]); grid on;
[s1,Fs]=audioread('record.m4a');
x1=s1(:,1);
% sound(x1,Fs);
N1=length(x1);
Y1=fft(x1,N1);
f1=Fs*(0:N1-1)/N1;
t1=(0:N1-1)/Fs;
subplot(2, 2, 2);
plot(f1,abs(Y1))
xlabel('频率/Hz');ylabel('幅度');
title('原始信号频谱');
grid on;axis([0 50000 0 200])
y=filter(num,den,x1); % 滤波
pause(3);
sound(y,Fs);
N2=length(y);
Y2=fft(y,N2);
f2=Fs*(0:N2-1)/N2;
t2=(0:N2-1)/Fs;
subplot(2, 2, 3);
plot(f2,abs(Y2))
xlabel('频率/Hz'); ylabel('幅度');
title('过滤后信号的频谱'); grid on;
axis([0 50000 0 200])