clear;
% 语音信号的频谱分析
[y, fs] = audioread('record.m4a');
sound(y, fs);           % 回放语音信号,返回样本数据 y,以及该数据的采样率 Fs
n = length(y);          %选取变换的点数 
Y = fft(y, n);          %对n点进行傅里叶变换到频域

figure(1);
subplot(2,1,1);
plot(y);                %语音信号的时域波形图
title('原始语音信号采样后时域波形');
xlabel('时间轴')
ylabel('幅值 A')

P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引

subplot(2, 1, 2);
f = fs*(0:(n/2))/n;     % 对应点的频率，取数组中对应下标的元素
plot(f, P1); %语音信号的频谱图
title('原始语音信号采样后频谱图');
xlabel('频率Hz');
ylabel('频率幅值');
% figure(1); subplot(2, 1, 1); stem(P1); subplot(2, 1, 2); plot(P1);

% 设计数字滤波器，并画出其频率响应

