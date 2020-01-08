% https://wenku.baidu.com/view/00deb3bdfd4ffe4733687e21af45b307e971f906.html
% https://www.jianshu.com/p/c01103a3f534


% f=fs*(0:512)/1024
% fs是已经前面设定的采样频率，这里假定是1000；语句作用是将500长度分为513（0到512）个点

Fs = 15000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 1024;             % Length of signal
t = (0:L-1)*T;        % Time vector

f1 = 1500;
f2 = 2500;
n = 0:L-1;
S = 0.7*cos(2*pi*f1*t) + sin(2*pi*f2*t);

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;   % Define the frequency domain f

plot(f,P1)
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
