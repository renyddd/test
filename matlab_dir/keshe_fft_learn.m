% P88
% guanwang ziliao ww2.mathworks.cn/help/signal/ug/discrete-fourier-transform.html
xn = [ 1 1 1 1 ];
xk16 = fft(xn ,16);
xk32 = fft(xn, 32);
% figure(1); subplot(2, 1, 1); plot(xk16); subplot(2, 1, 2); plot(xk32)
%  此时的图像与课本所示不同，是因为单位选择的问题吗？

% stem(xk16) % 绘制针状图

clear; clc;
t = 0:1/100:10-1/100; 
x = sin(2*pi*15*t) + sin(2*pi*40*t);      % Signal
y = fft(x);                               % Compute DFT of x
m = abs(y);                               % Magnitude
y(m<1e-6) = 0;
p = unwrap(angle(y));                     % Phase

f = (0:length(y)-1)*100/length(y);        % Frequency vector

subplot(2,1,1)
plot(f,m)
title('Magnitude')

subplot(2,1,2)
plot(f,p*180/pi)
title('Phase')
