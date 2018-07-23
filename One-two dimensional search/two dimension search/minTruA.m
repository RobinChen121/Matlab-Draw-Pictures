function [x,minf]=minTruA(f,x0,r0,mu,yita,var,eps)
%Ŀ�꺯����f;
%��ʼ�㣺x0;
%��ʼ�����뾶��r0��
%��ʼ������mu
%��ʼ������yita
%�Ա���������var
%���ȣ�eps

if nargin==6
    eps=1.0e-6;
end
tol=1;
x0=transpose(x0);
r=r0;
j=1;

while tol>eps
    gradf=jacobian(f,var);
    jacf=jacobian(gradf,var); %�ſ˱Ⱦ���
    fx=Funval(f,var,x0);
    v=Funval(gradf,var,x0);
    pv=Funval(jacf,var,x0);
    tol=norm(v);
    
    H=double(pv);
    c=transpose(v);
    lb=-r*ones(length(var),1);%rΪ������뾶
    ub=r*ones(length(var),1);
    [y,fy]=quadprog(H,c,[],[],[],[],lb,ub);%�������ӹ滮
    
    fx_n=Funval(gradf,var,x0+y);
    p=(fx-fx_n)/(-fy);
    if p<=mu%�޸�������뾶
        r=0.5*r;
    else
        x0=x0+y;
        if p>=yita
            r=2*r;
        end
    end
end
x=x0;
minf=Funval(f,var,x);
format short;