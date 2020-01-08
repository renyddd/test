clear; % 窗函数 fir
wp = pi / 2;
ws = pi / 4;
Bt = wp - ws;
N0 = ceil(6.2 * pi / Bt);   % 表 7.2.2  算出汉宁窗 h(n) 长度 N0
N = N0 + mod(N0 + 1, 2);    % 确保 N 是奇数
wc = (wp + ws) / 2 / pi;
% hn = fir1(N-1, wc, 'high', hanning(N));
hn = fir1(N-1, wc)

freqz(hn);