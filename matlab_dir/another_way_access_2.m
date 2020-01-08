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
    % record ����Ч����Ϊ���ԣ�����¼������Ƶ���޷���ʾ
    % bilibili.m4a Ƶ�ʲ����˲�
    sound(y,fs)      % �ط������ź�

    figure(1);
    subplot(2, 2, 2); plot(y)
    title('�źŵ�ʱ����');
    output = filter(Hd, y)
    subplot(2, 2, 4); plot(output)
    title('�˲����ʱ����');

    % ��ʾƵ���ź�
    n = length(y);          % ѡȡ�任�ĵ��� 
    Y = fft(y, n);          % ��n����и���Ҷ�任��Ƶ��
    P2 = abs(Y/n);
    P1 = P2(1:n/2+1);
    P1(2:end-1) = 2*P1(2:end-1); % end: ��ֹ������ָʾ�����������

    subplot(2, 2, 1);
    f = fs*(0:(n/2))/n;     % ��Ӧ���Ƶ�ʣ�ȡ�����ж�Ӧ�±��Ԫ��
    plot(f, P1); %�����źŵ�Ƶ��ͼ
    title('ԭʼ�����źŲ�����Ƶ��ͼ'); xlabel('Ƶ��Hz'); ylabel('Ƶ�ʷ�ֵ');

    n = length(output);          %ѡȡ�任�ĵ��� 
    Y = fft(output, n);          %��n����и���Ҷ�任��Ƶ��
    P2 = abs(Y/n);
    P1 = P2(1:n/2+1);
    P1(2:end-1) = 2*P1(2:end-1); % end: ��ֹ������ָʾ�����������
    subplot(2, 2, 3);
    f = fs*(0:(n/2))/n;          % ��Ӧ���Ƶ�ʣ�ȡ�����ж�Ӧ�±��Ԫ��
    plot(f, P1); %�����źŵ�Ƶ��ͼ

    pause(3); 
    sound(output, fs);

end