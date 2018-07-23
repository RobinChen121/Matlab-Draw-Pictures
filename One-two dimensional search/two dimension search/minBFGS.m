function [x,minf]=minBFGS(f,x0,var,eps)
%Ŀ�꺯����f;
%��ʼ�㣺x0;
%�Ա���������var;
%Ŀ�꺯��ȡ��Сֵʱ���Ա���ֵ��x;
%Ŀ�꺯������Сֵ��minf

format long;
if nargin==3
    eps=1.0e-3;
end
x0=transpose(x0);%��ʼֵ��ת��
n=length(var);%�Ա�������
syms l;%lĬ��ֵΪ1
H=eye(n,n); %��ʼH����   
gradf=jacobian(f,var);  %�ݶȾ���
v0=Funval(gradf,var,x0);%�ݶȾ���ֵ
p=-H*transpose(v0);%��ʼ�½�����
k=0;
i=0;

while 1
    k=0;
    v=Funval(gradf,var,x0); %����ʼֵ�����ݶȾ���
    tol=norm(v) %�ݶȾ��������ʽֵ
    i=i+1;
    Tg(i)=Funval(f,var,x0)
    if tol<=eps %������ֹ����
        x=x0;
        break;
    end
    y=x0+l*p;%����ֵ
    yf=Funval(f,var,y);
    [a,b]=minJT(yf,0,0.1);%�ý��˷�ȷ����������
    xm=minGX(yf,a,b)%�ûƽ�ָȷ����������
    x1=x0+xm*p;%��һ��������
    vk=Funval(gradf,var,x1);%�µ���ݶ�ֵ
    tol=norm(vk);%�����жϱ�׼
    if tol<=eps
        x=x1;
        break;
    end
    if k==n
        x0=x1;
        continue;
    else
        dx=x1-x0;
        dgf=vk-v;
        dgf=transpose(dgf);
        dxT=transpose(dgf);
        dgfT=transpose(dgf);
        mdx=dx*dxT;
        mdgf=dgf*dgfT;
        H=H+(1+dgfT*(H*dgf)/(dxT*dgf))*mdx/(dxT*dgf)-(dx*dgfT*H+H*dgf*dxT)/(dxT*dgf);
        p=-H*transpose(vk);
        k=k+1;
        x0=x1;
    end
    x0
end
minf=Funval(f,var,x);
i
plot(Tg)
format short;



