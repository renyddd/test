x=[1,2,3,1,2,4,6,7,1,3,5,7,5,3,1,4,5,6,2,6,2];
h=[1,2,1,2,3];
nh=0:4;nx=0:20;
nx1=0:6,nx2=7:13;nx3=14:20;
n=0:10;
%序列的分段
x1=[1,2,3,1,2,4,6];
x2=[7,1,3,5,7,5,3];
x3=[1,4,5,6,2,6,2];
H=fft(h,11);
X=fft(x,25);
X1=fft(x1,11);
X2=fft(x2,11);
X3=fft(x3,11);
%用DFT计算线性卷积
H1=fft(h,25);Y=H1.*X;y=ifft(Y);
%每段序列与h(n）卷积
Y1=H.*X1;Y2=H.*X2;Y3=H.*X3;
y1=ifft(Y1);y2=ifft(Y2);y3=ifft(Y3);
%每段卷积的结果相加
yc=[y1,zeros(1,14)]+[zeros(1,7),y2,zeros(1,7)]+[zeros(1,14),y3];
subplot(5,1,1);stem(n,y1);
xlabel('n');ylabel('y_{1}');axis([0 26 0 60]);
subplot(5,1,2);stem(n+7,y2);
xlabel('n');ylabel('y_{2}');axis([0 26 0 60]);
subplot(5,1,3);stem(n+14,y3);
xlabel('n');ylabel('y_{3}');axis([0 26 0 60]);
subplot(5,1,4);stem(yc);
xlabel('n');ylabel('y_ {c}=y_{1}+y_{2}+y_{3}');axis([0 26 0 60]);
subplot(5,1,5);stem(y);
xlabel('n');ylabel('y=x*h');axis([0 26 0 60]);