function y=fftconv(x1,x2,N)
%快速傅里叶变换计算线性卷积自定义函数
Xk1=fft(x1,N);     %调用快速算法fft求X(k)=DFT[x1(n)]
Xk2=fft(x2,N);    %调用快速算法fft求H(k)=DFT[x2(n)]
YK=Xk1.*Xk2;      %求Y(k)=X1(k)X2(k)
y=ifft(YK);       %调用快速逆算法ifft求y(n0=IDFT[Y(k)]
end