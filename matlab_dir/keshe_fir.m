clear; % ������ fir
wp = pi / 2;
ws = pi / 4;
Bt = wp - ws;
N0 = ceil(6.2 * pi / Bt);   % �� 7.2.2  ��������� h(n) ���� N0
N = N0 + mod(N0 + 1, 2);    % ȷ�� N ������
wc = (wp + ws) / 2 / pi;
% hn = fir1(N-1, wc, 'high', hanning(N));
hn = fir1(N-1, wc)

freqz(hn);