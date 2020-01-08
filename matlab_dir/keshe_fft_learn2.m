% https://ww2.mathworks.cn/help/matlab/ref/fft.html

% 指定信号的参数，采样频率为 1 kHz，信号持续时间为 1.5 秒
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

% 构造一个信号，其中包含幅值为 0.7 的 50 Hz 正弦量和幅值为 1 的 120 Hz 正弦量
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

% 用均值为零、方差为 4 的白噪声扰乱该信号
X = S + 2*randn(size(t));

% 在时域中绘制噪声信号。通过查看信号 X(t) 很难确定频率分量
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

% 现在，采用原始的、未破坏信号的傅里叶变换并检索精确幅值 0.7 和 1.0
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')