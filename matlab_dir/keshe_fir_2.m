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
sound(X,fs)      % 回放语音信号
n=length(X)  %选取变换的点数 

% 在时域中绘制噪声信号。通过查看信号 X(t) 很难确定频率分量
figure(1);
plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);
% 计算双侧频谱 P2。然后基于 P2 和偶数信号长度 L 计算单侧频谱 P1
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引

% 定义频域 f 并绘制单侧幅值频谱 P1。与预期相符，由于增加了噪声，幅值并不精确等于 0.7 和 1
% 一般情况下，较长的信号会产生更好的频率近似值
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% go into filter
res = fftfilt(hn ,Y);

% 计算双侧频谱 P2。然后基于 P2 和偶数信号长度 L 计算单侧频谱 P1
P4 = abs(res/L);
P3 = P4(1:L/2+1);
P3(2:end-1) = 2*P3(2:end-1); % end: 终止代码块或指示最大数组索引
figure(2);
plot(f, P3);