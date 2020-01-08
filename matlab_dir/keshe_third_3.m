% https://www.jianshu.com/p/2a0d6d587bc3
clear;
[x,fs]=audioread('record.m4a');
fp = 1000; fc = 1200; Rs = 100; Rp = 1;
Wp = 2 * pi * fp; Ws = 2 * pi * fc;

[n,Wp]=cheb1ord(Wp,Ws,Rp,Rs);     % Cheby1
[b,a]=cheby1(n,Rp,Wp);
freqz(b,a,2048,fs);                    % 查看设计滤波器的曲线

y = filter(b,a,x);