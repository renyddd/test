% https://zhuanlan.zhihu.com/p/57902993
[x,fs]=audioread('record.m4a'); %�������ź�
sound(x,fs); %���������ź�
N=length(x); %����
n=0:N-1;
w=2*n*pi/N;
y1=fft(x); %��ԭʼ�ź���FFT�任
figure(1); subplot(2,1,1);
plot(n,x) %��ԭʼ�����źŵ�ʱ����ͼ
title('ԭʼ�����ź�ʱ��ͼ');
xlabel('ʱ��t');
ylabel('��ֵ');
subplot(2,1,2); %��ԭʼ�����źŵ�Ƶ��ͼ
plot(w/pi,abs(y1));
title('ԭʼ�����ź�Ƶ��')
xlabel('Ƶ��Hz');
ylabel('����');

% �˲������->˫���Ա任�����һ�����ֵ�ͨ�˲�����ԭʼ�����źŽ����˲�����
fp=800; fs=1300; rs=35; rp=0.5; Fs=44100;
wp=2*Fs*tan(2*pi*fp/(2*Fs));
ws=2*Fs*tan(2*pi*fs/(2*Fs));
% wp=4000*pi; ws=12000*pi; rp=1; rs=30;  % һ�����ֵ
[n,wn]=buttord(wp, ws, rp, rs, 's');
[b,a]=butter(n, wn, 's');
[num,den]=bilinear(b,a,Fs);         % for analog-to-digital filter conversion
figure(2); subplot(2, 2, 1);
[h,w]=freqz(num,den,512,Fs);
plot(w,abs(h));
xlabel('Ƶ��/Hz');ylabel('��ֵ');
title('������˹��ͨ�˲�����������');
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
xlabel('Ƶ��/Hz');ylabel('����');
title('ԭʼ�ź�Ƶ��');
grid on;axis([0 50000 0 200])
y=filter(num,den,x1); % �˲�
pause(3);
sound(y,Fs);
N2=length(y);
Y2=fft(y,N2);
f2=Fs*(0:N2-1)/N2;
t2=(0:N2-1)/Fs;
subplot(2, 2, 3);
plot(f2,abs(Y2))
xlabel('Ƶ��/Hz'); ylabel('����');
title('���˺��źŵ�Ƶ��'); grid on;
axis([0 50000 0 200])