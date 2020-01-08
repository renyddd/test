clc;clear;close all;
t1=0;t2=0;t3=0;t4=0;t5=0;t6=0;t7=0;t8=0;t9=0;
t10=0;M=5;
n=0:100;h=sin(0.4*pi*n);
for i=1:M
    x=2*rand(1,10^6)-1;  %产生均匀分布在[-1,1]区间的数据
    %调用MATLAB提供的卷积函数conv()计算耗时
    t0=clock;y1=conv(x,h);t1=t1+etime(clock,t0);
    %调用MATLAB提供的重叠相加函数fftfilt()计算耗时
    t0=clock;y2=fftfilt(h,x,1024);t2=t2+etime(clock,t0);
    t0=clock;y3=fftfilt(h,x,2048);t3=t3+etime(clock,t0);
    t0=clock;y4=fftfilt(h,x,4096);t4=t4+etime(clock,t0);
    %调用重叠相加函数overaddfft()计算耗时
    t0=clock;y5=overaddfft(x,h,924);t5=t5+etime(clock,t0);
    t0=clock;y6=overaddfft(x,h,1948);t6=t6+etime(clock,t0);
    t0=clock;y7=overaddfft(x,h,3996);t7=t7+etime(clock,t0);
end
disp('调用MATLAB提供的卷积函数conv()计算平均耗时(s)');
t1=t1/M                           %求平均
disp('调用MATLAB提供的重叠相加函数fftfilt()计算平均耗时(s)');
t2=t2/M
t3=t3/M
t4=t4/M
disp('调用重叠相加函数overaddfft()计算平均耗时(s)');
t5=t5/M
t6=t6/M
t7=t7/M