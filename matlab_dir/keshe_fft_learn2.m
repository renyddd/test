% https://ww2.mathworks.cn/help/matlab/ref/fft.html

% ָ���źŵĲ���������Ƶ��Ϊ 1 kHz���źų���ʱ��Ϊ 1.5 ��
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

% ����һ���źţ����а�����ֵΪ 0.7 �� 50 Hz �������ͷ�ֵΪ 1 �� 120 Hz ������
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

% �þ�ֵΪ�㡢����Ϊ 4 �İ��������Ҹ��ź�
X = S + 2*randn(size(t));

% ��ʱ���л��������źš�ͨ���鿴�ź� X(t) ����ȷ��Ƶ�ʷ���
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

% ���ڣ�����ԭʼ�ġ�δ�ƻ��źŵĸ���Ҷ�任��������ȷ��ֵ 0.7 �� 1.0
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')