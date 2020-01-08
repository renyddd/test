% P233 lowpath
clear; clc;
fp = 1500; fs = 2500; rs = 40; Fs = 10000;
wp = 2 * pi * fp / Fs; ws = 2 * pi * fs / Fs;
Bt = ws - wp;
alph = 0.5842 * (rs - 21)^0.4 + 0.07886 * (rs - 21);
M = ceil((rs - 8) / 2.285 / Bt);
wc = (wp + ws) / 2 / pi;
hn = fir1(M, wc, kaiser(M+1, alph));

% produce signal
% Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

[X,fs]=audioread('record.m4a');
sound(X,fs)      % �ط������ź�
n=length(X)  %ѡȡ�任�ĵ��� 

% ��ʱ���л��������źš�ͨ���鿴�ź� X(t) ����ȷ��Ƶ�ʷ���
figure(1);
plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);
% ����˫��Ƶ�� P2��Ȼ����� P2 ��ż���źų��� L ���㵥��Ƶ�� P1
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: ��ֹ������ָʾ�����������

% ����Ƶ�� f �����Ƶ����ֵƵ�� P1����Ԥ�������������������������ֵ������ȷ���� 0.7 �� 1
% һ������£��ϳ����źŻ�������õ�Ƶ�ʽ���ֵ
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% go into filter
res = fftfilt(hn ,Y);

% ����˫��Ƶ�� P2��Ȼ����� P2 ��ż���źų��� L ���㵥��Ƶ�� P1
P4 = abs(res/L);
P3 = P4(1:L/2+1);
P3(2:end-1) = 2*P3(2:end-1); % end: ��ֹ������ָʾ�����������
figure(2);
plot(f, P3);