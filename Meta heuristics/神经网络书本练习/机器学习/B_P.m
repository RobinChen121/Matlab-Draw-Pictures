%clc;
%clear;
%��������
[a1,a2,a3]=textread('dataset1.txt','%f%f%c');
[b1,b2,b3]=textread('dataset1.txt','%f%f%c');
[c1,c2,c3]=textread('dataset1.txt','%f%f%c');

%���Ա������־����ʾ����
n1=length(a3);
n2=length(b3);
n3=length(c3);
output=zeros(n1+n2+n3,2);
for i=1:n1
    switch a3(i)
        case 'm'
            output(i,:)=[1 0];
        case 'M'
            output(i,:)=[1 0];
        case 'f'
            output(i,:)=[0 1];
        case 'F'
            output(i,:)=[0 1];
    end
end
for i=1:n2
    switch b3(i)
        case 'm'
            output(n1+i,:)=[1 0];
        case 'M'
            output(n1+i,:)=[1 0];
        case 'f'
            output(n1+i,:)=[0 1];
        case 'F'
            output(i,:)=[0 1];
    end
end
for i=1:n3
    switch c3(i)
        case 'm'
            output(n1+n2+i,:)=[1 0];
        case 'M'
            output(n1+n2+i,:)=[1 0];
        case 'f'
            output(n1+n2+i,:)=[0 1];
        case 'F'
            output(i,:)=[0 1];
    end
end

%ǰ����������Ϊѵ�����ݣ����һ��������Ϊ��������
input_train=[a1 a2;b1 b2]';
input_test=[c1 c2]';
output_train=output(1:n1+n2,:)';
output_test=output(n1+n2+1:n1+n2+n3,:)';

%�������ݹ�һ��
inputn= input_train./repmat(sqrt(sum(input_train.*input_train)),size(input_train,1),1);

%����ṹ
innum=2;
midnum=3;
outnum=2;
nita=0.8;

%Ȩֵ��ֵ��ʼ��
w1=rands(midnum,innum);
b1=rands(midnum,1);
w2=rands(midnum,outnum);
b2=rands(outnum,1);

E=zeros(20,1); %����ÿ�ε������
for ii=1:20  %ѵ��20��
    E(ii)=0;
    for i=1:n1+n2
        x=inputn(:,i);  %ѡ�񱾴�ѵ������
        
        %���������
        I=zeros(midnum,1);
        Iout=zeros(1,outnum);
        for j=1:midnum
            I(j)=x'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
        end
        %��������
        yn=w2'*Iout'+b2;
        
        %Ԥ�����
        e=output_train(:,i)-yn;
        E(ii)=E(ii)+sum(abs(e));
        
        %����w2,b2������
        dw2=e*Iout;
        db2=e';
        
        %����w1,b1������
        FI=zeros(1,midnum);
        for j=1:midnum
            S=1/(1+exp(-I(j)));
            FI(j)=S*(1-S);
        end
        dw1=zeros(innum,midnum);
        db1=zeros(1,midnum);
        for k=1:innum
            for j=1:midnum
               dw1(k,j)=FI(j)*x(k)*(e(1)*w2(j,1)+e(2)*w2(j,2));    
               db1(j)=FI(j)*(e(1)*w2(j,1)+e(2)*w2(j,2));
            end
        end
        w1=w1+nita*dw1';
        b1=b1+nita*db1';
        w2=w2+nita*dw2';
        b2=b2+nita*db2';
    end    
end

%�������ݹ�һ��
inputn_test= input_test./repmat(sqrt(sum(input_test.*input_test)),size(input_test,1),1);
fore=zeros(2,n3);
for i=1:n3
    for j=1:midnum
        I(j)=inputn_test(:,i)'*w1(j,:)'+b1(j);
        Iout(j)=1/(1+exp(-I(j)));
    end
    fore(:,i)=w2'*Iout'+b2;
end

%output_fore=zeros(n3,1);
for i=1:n3
    output_fore(i)=find(fore(:,i)==max(fore(:,i)));
end
error=output_fore-output_test';
disp;




