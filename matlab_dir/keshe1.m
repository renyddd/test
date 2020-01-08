clear;
[y,fs]=audioread('record.m4a');
sound(y,fs)      % 回放语音信号
n=length(y)  %选取变换的点数 
y_p=fft(y,n);      %对n点进行傅里叶变换到频域
f=fs*(0:n/2-1)/n;   % 对应点的频率
figure(1)
subplot(2,1,1);
plot(y);                    %语音信号的时域波形图
title('原始语音信号采样后时域波形');
xlabel('时间轴')
ylabel('幅值 A')
subplot(2,1,2);
plot(f,abs(y_p(1:n/2)));     %语音信号的频谱图，取数组中对应下标的元素
% 理解单位的变换才是关键，绘图就是对 plot 的调用。信号处理的知识才是使用的基础。
title('原始语音信号采样后频谱图');
xlabel('频率Hz');
ylabel('频率幅值');

% 对加噪的语音信号进行去噪程序如下：
fp=1500;fc=1700;As=100;Ap=1;
% (以上为低通滤波器的性能指标）
wc=2*pi*fc/fs; wp=2*pi*fp/fs;
wdel=wc-wp;
beta=0.112*(As-8.7);
N=ceil((As-8)/2.285/wdel);
wn= kaiser(N+1,beta);
ws=(wp+wc)/2/pi;
b=fir1(N,ws,wn);
figure(3);
freqz(b,1);
title('低通滤波器的幅频图');
xlabel('频率/hz');
ylabel('幅度/db');
%（此前为低通滤波器设计阶段）——接下来为去除噪声信号的程序——
x=fftfilt(b,y_z);
X=fft(x,n);
figure(4);
subplot(2,2,1);plot(f,abs(y_zp(1:n/2)));
title('滤波前信号的频谱');
subplot(2,2,2);plot(abs(X));
title('滤波后信号频谱');
subplot(2,2,3);plot(y_z);
title('滤波前信号的波形')
subplot(2,2,4);plot(x);
title('滤波后信号的波形')
pause(5);
sound(x,fs)  %回放滤波后的音频