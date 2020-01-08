clear;
[y,fs]=audioread('record.m4a');
sound(y,fs)      % 回放语音信号
n=length(y)  %选取变换的点数 

%画出原始语音时域图
figure(11) 
plot(y);
xlabel('时间（ms)'); 
ylabel('幅值');
title('原始语音时域图');

%画出原始语音做FFT变换后频谱图
Y1=fft(y);
Y=abs(Y1);
figure(12)
plot(Y);
xlabel('频率'); 
ylabel('幅值');
title('原始语音做FFT变换后频谱图');


        %FIR低通滤波器
        fs=10000;
        wp=2*pi*1000/fs;
        wst=2*pi*1200/fs;
        Rp=1;
        Rs=100;
        wdelta=wst-wp;
        N=ceil(8*pi/wdelta);              %取整
        wn=(wp+wst)/2;
        [b,a]=fir1(N,wn/pi,hamming(N+1));       %选择窗函数，并归一化截止频率
        figure(21)
        freqz(b,a,512);
        title('FIR低通滤波器');
        
        y1=filter(b,a,y);
        figure(22)
        subplot(2,1,1)
        plot(y)
        title('FIR低通滤波器滤波前的时域波形');
        xlabel('时间（ms)'); 
        ylabel('幅值'); 
        subplot(2,1,2)
        plot(y1);
        title('FIR低通滤波器滤波后的时域波形');
        xlabel('时间（ms)'); 
        ylabel('幅值');    
        
        sound(y1,8000);                    %播放滤波后的语音信号
