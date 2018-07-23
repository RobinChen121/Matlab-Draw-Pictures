function [x,minf]=miFactor(f,x0,g,w,alpha,var,eps)
%Ŀ�꺯����f;
%��ʼ�㣺x0;
%Լ��������g;
%���ӣ�w;
%�Ŵ�ϵ����alpha��
%�Ա���������var;
%���ȣ�eps��
%Ŀ�꺯��ȡ��Сֵʱ���Ա���ֵ��x;
%Ŀ�꺯������Сֵ��minf

format long;
if nargin==6
    eps=1.0e-4;
end

n=length(g);
while l
    for i=1:n
        gv(i)=subs(g,var,x0);
        if gv(i)>w(i)/alpha
            fg(i)=-0.5*w(i)^2/alpha;
        else
            fg(i)=0.5*((w(i)-alpha*g(i))^2-w(i)^2)/alpha;
        end
    end
    newf=f+sum(fg);
    [xm,minf]=minTruA(newf,x0,0.1,0.3,0.7,var);%�������򷽷����
    

FE=0;
