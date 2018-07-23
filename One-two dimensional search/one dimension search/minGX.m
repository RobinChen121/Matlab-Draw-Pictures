function [x,minf]=minGX(f,a,b,eps) %�����½���
format long;
if nargin==3
    eps=1.0e-6;
end
k=1;
tol=b-a;
diff=jacobian(f,findsym(f));

while tol>eps && k<1000
    fb=subs(diff,findsym(f),b)
    fa=subs(diff,findsym(f),a)
    xa=b;
    xb=b-(b-a)*fb/(fb-fa);
    a=b
    b=xb
    tol=abs(b-a);
end
if k==1000
    disp('�Ҳ�����Сֵ');
    x=NaN;
    minf=NaN;
    return;
end
x=(a+b)/2;
minf=subs(f,findsym(f),x);
format short;
    