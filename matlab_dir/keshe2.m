clear;
[y,fs]=audioread('record.m4a');
sound(y,fs)      % �ط������ź�
n=length(y)  %ѡȡ�任�ĵ��� 

%����ԭʼ����ʱ��ͼ
figure(11) 
plot(y);
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');
title('ԭʼ����ʱ��ͼ');

%����ԭʼ������FFT�任��Ƶ��ͼ
Y1=fft(y);
Y=abs(Y1);
figure(12)
plot(Y);
xlabel('Ƶ��'); 
ylabel('��ֵ');
title('ԭʼ������FFT�任��Ƶ��ͼ');


        %FIR��ͨ�˲���
        fs=10000;
        wp=2*pi*1000/fs;
        wst=2*pi*1200/fs;
        Rp=1;
        Rs=100;
        wdelta=wst-wp;
        N=ceil(8*pi/wdelta);              %ȡ��
        wn=(wp+wst)/2;
        [b,a]=fir1(N,wn/pi,hamming(N+1));       %ѡ�񴰺���������һ����ֹƵ��
        figure(21)
        freqz(b,a,512);
        title('FIR��ͨ�˲���');
        
        y1=filter(b,a,y);
        figure(22)
        subplot(2,1,1)
        plot(y)
        title('FIR��ͨ�˲����˲�ǰ��ʱ����');
        xlabel('ʱ�䣨ms)'); 
        ylabel('��ֵ'); 
        subplot(2,1,2)
        plot(y1);
        title('FIR��ͨ�˲����˲����ʱ����');
        xlabel('ʱ�䣨ms)'); 
        ylabel('��ֵ');    
        
        sound(y1,8000);                    %�����˲���������ź�
