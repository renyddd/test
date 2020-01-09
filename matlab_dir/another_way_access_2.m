% https://blog.csdn.net/qsj8362234/article/details/8275511
clear;
q='q';
while (1) 
    clc;
    getch = input('1 for ellip\n2 for kaiser\n3 for butter\nq for quit\n======= tyep a value =======: '); 
    
    if getch == q
        break;
    elseif getch == 1
        Hd = auto_ellip_highpass;
    elseif getch == 2
        Hd = auto_kaiser_lowpass;
    elseif getch == 3
        Hd = auto_butter_lowpass;
    elseif getch == 4
        Hd = auto_cheby_bandpass;
    elseif getch == 5
        Hd = auto_cheby_bandstop;
    end

    [y,fs]=audioread('record_jita.m4a'); 
    % record 过滤效果最为明显，耳机录音今后的频谱无法显示
    % bilibili.m4a 频率测试滤波
    sound(y,fs)      % 回放语音信号

    figure(1);
    subplot(2, 2, 2); plot(y)
    title('信号的时域波形');
    
    output = filter(Hd, y);
    
    subplot(2, 2, 4); plot(output)
    title('滤波后的时域波形');

    % 显示频域信号
    n = length(y);          % 选取变换的点数 
    Y = fft(y, n);          % 对n点进行傅里叶变换到频域
    P2 = abs(Y/n);
    P1 = P2(1:n/2+1);
    P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引

    subplot(2, 2, 1);
    f = fs*(0:(n/2))/n;     % 对应点的频率，取数组中对应下标的元素
    plot(f, P1); %语音信号的频谱图
    title('原始语音信号采样后频谱图'); xlabel('频率Hz'); ylabel('频率幅值');

    n = length(output);          %选取变换的点数 
    Y = fft(output, n);          %对n点进行傅里叶变换到频域
    P2 = abs(Y/n);
    P1 = P2(1:n/2+1);
    P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引
    subplot(2, 2, 3);
    f = fs*(0:(n/2))/n;          % 对应点的频率，取数组中对应下标的元素
    plot(f, P1); %语音信号的频谱图

    pause(3); 
    sound(output, fs);
    cla

end