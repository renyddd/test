clear;
% �����źŵ�Ƶ�׷���
[y, fs] = audioread('record.m4a');
sound(y, fs);           % �ط������ź�,������������ y,�Լ������ݵĲ����� Fs
n = length(y);          %ѡȡ�任�ĵ��� 
Y = fft(y, n);          %��n����и���Ҷ�任��Ƶ��

figure(1);
subplot(2,1,1);
plot(y);                %�����źŵ�ʱ����ͼ
title('ԭʼ�����źŲ�����ʱ����');
xlabel('ʱ����')
ylabel('��ֵ A')

P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: ��ֹ������ָʾ�����������

subplot(2, 1, 2);
f = fs*(0:(n/2))/n;     % ��Ӧ���Ƶ�ʣ�ȡ�����ж�Ӧ�±��Ԫ��
plot(f, P1); %�����źŵ�Ƶ��ͼ
title('ԭʼ�����źŲ�����Ƶ��ͼ');
xlabel('Ƶ��Hz');
ylabel('Ƶ�ʷ�ֵ');
% figure(1); subplot(2, 1, 1); stem(P1); subplot(2, 1, 2); plot(P1);

% ��������˲�������������Ƶ����Ӧ

