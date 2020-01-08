function y=overaddfft(x,h,L)
%*******�ص���ӷ�**********
%xΪ������ź�����x(n)
%hΪLTI�ĵ�λ�弤��Ӧ����h(n)
%LΪ���ź�����x�ķֶγ���
M=length(h);
if L<M
    L=M+1;                             %��֤�źŵķֶγ���L����M
end
N=M+L-1;
Lx=length(x);
T=ceil(Lx/L);                           %ȡ��
t=zeros(1,M-1);
x=[x,zeros(1,(T+1)*N-Lx)];              %����ʹ֮�ܹ��պ÷ֳ�������
y=zeros(1,(T+1)*L);                     %������е��ܳ���(T+1)*L
for i=0:1:T                             %�ֶμ���
    xi=i*L+1;
    x_seg=x(xi:xi+L-1);                 %ȡһ���źŸ�������x_seg
    y_seg=fftconv(x_seg,h,N);           %���ÿ��پ������fftconv()
    y_seg(1:M-1)=y_seg(1:M-1)+t(1:M-1);  %M-1���ص����
    t(1:M-1)=y_seg(L+1:N);     %ȡ��ǰ��ǰM-1�� 
    y(xi:xi+L-1)=y_seg(1:L);   %�����μ������ν�����
end
y=y(1:Lx+M-1);            %��������
end