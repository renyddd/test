function y=fftconv(x1,x2,N)
%���ٸ���Ҷ�任�������Ծ���Զ��庯��
Xk1=fft(x1,N);     %���ÿ����㷨fft��X(k)=DFT[x1(n)]
Xk2=fft(x2,N);    %���ÿ����㷨fft��H(k)=DFT[x2(n)]
YK=Xk1.*Xk2;      %��Y(k)=X1(k)X2(k)
y=ifft(YK);       %���ÿ������㷨ifft��y(n0=IDFT[Y(k)]
end