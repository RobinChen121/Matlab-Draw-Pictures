function [xm,fv,saveinventory]=NewGAEOQ3  %û��Լ���������й�Ӧ�̣�����k.Deeb������
%%��ʼĿ�꺯����Լ������
clear;
D=500;p=1/1000;Dcoe=5;Ab=50;Av=80;hb=10;hv=6;backcost=200;a=1;b=4;c=1;  %%����ģ���еĲ���
a0=0;breal=0.15;bint=0.35;preal=10;pint=4; %%�Ŵ��㷨�еĲ���
syms z k; 
intloss=matlabFunction(int((z-k)*normpdf(z,0,1),z,k,inf)); %����ȱ�����ֺ���
f=@(q,k,m)(Av*D/(m*q)+hv*q*(m*(1-D*p)-1+2*D*p)/2+Ab*D/q+hb*(q/2+k*Dcoe*sqrt(a*(b-q)^2+c))+backcost*D*Dcoe*sqrt(a*(b-q)^2+c)*intloss(k)/q);
f=@(x)f(x(1),x(2),x(3));
qmin=1e-1;
qmax=10000;  %�������½�
kmin=1e-1;
kmax=100;
mmin=1e-1;
mmax=100;
NP=100; %�������ٴ����˹�ָ����ֵ

%%��ʼ����Ⱥ
size=30; %��Ⱥ����,��Ⱥ����Ϊ�������ĸ�������10
E=zeros(size,6); %ǰ����Ϊ��ʼ�⣬������Ϊ��Ӧ����ֵ�������м�¼�Ƿ�Ϊ���н⣬�����м�¼Υ��Լ�������Ĳ�ֵ
E(:,1)=qmin+(qmax-qmin)*rand(size,1);
E(:,2)=kmin+(kmax-kmin)*rand(size,1);
E(:,3)=ceil(mmin+(mmax-mmin)*rand(size,1));
fv=inf;%��ʼ����ֵΪ������ֵ
D=zeros(NP,4);%������¼ÿ�������Ž�,ƽ��ֵ������,���Ž��Ƿ�Ϊ���н�

%%������Ӧ����������ֵ
for i=1:size
    E(i,4)=f(E(i,1:3));
end
fmax=max(E(:,3));

%%�Ŵ�����   %%���ⲽ��Ӧֵ��û����
for g=1:NP    %%ԭ��������������k��ǰ���k�ظ���
    %for i=1:size   %%С��̬����
        %A=randperm(size,1);
        %dij=1;
        %j=0;
        %while j<=floor(0.25*size);
            %if dij<0.1 
               %B=randperm(size,1);
               %if E(A,r)<=E(B,4)
                   %M(i,:)=E(A,(1:3));
               %else
                   %M(i,:)=E(B,(1:3));
               %end
               %break;
            %else
                %B=randperm(size,1);
                %dij=sqrt(1/3*(E(A,1)-E(B,1)).^2/(qmax-qmin).^2+1/3*(E(A,2)-E(B,2)).^2/(kmax-kmin).^2+1/3*(E(A,3)-E(B,3)).^2/(mmax-mmin).^2);
                %j=j+1;
            %end
        %end
        %if j>floor(0.25*size)
           %M(i,:)=E(A,(1:3));
        %end
    %end
    
    M=zeros(size,3);%�����洢��ʤ�ߵ��м����    
    for i=1:size   %%������ѡ�����ĸ�������־�����ѡ��ʽӦ���ǶԵģ������
        A=randperm(size,2);  
        if E(A(1),4)<=E(A(2),4)
            M(i,:)=E(A(1),(1:3));
        else
            M(i,:)=E(A(2),(1:3));
        end 
    end

    %%������˹����
    E=zeros(size,6);  %����Ⱥ�������㣬������¼���������
    for j=1:size/2
        A=randperm(size,2);
        r=rand();   %�Ե�һ����������
        u=rand();
        if r>0.5
            beita=a0+breal*log(u);
        else
            beita=a0-breal*log(u);
        end
        E(2*j-1,1)=M(A(1),1)+beita*abs(M(A(1),1)-M(A(2),1));
        E(2*j,1)=M(A(2),1)+beita*abs(M(A(1),1)-M(A(2),1));
    %%ֻ�ڿ��н�ʱ��������ô���£��ǲ��Ǳ����ԭ���Ѿ���
        r=rand();   %�Եڶ�����������
        u=rand();
        if r>0.5
            beita=a0+breal*log(u);
        else
            beita=a0-breal*log(u);
        end
        E(2*j-1,2)=M(A(1),2)+beita*abs(M(A(1),2)-M(A(2),2));
        E(2*j,2)=M(A(2),2)+beita*abs(M(A(1),2)-M(A(2),2));
        r=rand();   %�Ե�������������
        u=rand();
        if r>0.5
            beita=a0+bint*log(u);
        else
            beita=a0-bint*log(u);
        end
        E(2*j-1,3)=M(A(1),3)+beita*abs(M(A(1),3)-M(A(2),3));
        E(2*j,3)=M(A(2),3)+beita*abs(M(A(1),3)-M(A(2),3));
    end

    %%���������죬�ñ���Ӧ�ò��ᵼ�¿��нⲻ���У���Deb���ĵ�һ���Ľ�
    for i=1:size
        s1=rand();
        s=s1^preal;
        t1=(M(i,1)-qmin)/(qmax-M(i,1)); %�Ե�һ����������
        if t1<rand()  
            E(i,1)=E(i,1)-s*(E(i,1)-qmin);
        else
            E(i,1)=E(i,1)+s*(E(i,1)-qmin);
        end
        t2=(M(i,2)-kmin)/(kmax-M(i,2)); %�Եڶ�����������
        if t2<rand()  
            E(i,2)=E(i,2)-s*(E(i,2)-kmin);
        else
            E(i,2)=E(i,2)+s*(E(i,2)-kmin);
        end
        t3=(M(i,3)-mmin)/(mmax-M(i,3)); %�Ե�������������
        s=s1^pint;
        if t3<rand()  
            E(i,3)=E(i,3)-s*(E(i,3)-kmin);
        else
            E(i,3)=E(i,3)+s*(E(i,3)-kmin);
        end
    end
    %%�Ե���������ȡ������
    for i=1:size
        if fix(E(i,3))~=E(i,3)
            v=rand();
            if v>0.5
                E(i,3)=fix(E(i,3))+1;
            else
                E(i,3)=fix(E(i,3));
            end
        end
    end
    
    %%�����Ӵ�������ֵ���ж��Ƿ�������н� 
    for i=1:size
        E(i,4)=f(E(i,(1:3)));
    end
    %for i=1:size
        %B(1)=subs(g1,[q,k],E(i,(1:2)));
        %if B(1)>=0
            %E(i,4)=1;
            %E(i,3)=subs(f,[q,k],E(i,(1:2)));%%��ֱ����Ľ����һ����Ҳ��EOQ�õ��Ľ����һ�� eval�����ԭ��
        %else
            %E(i,4)=0;
            %E(i,3)=0;
        %end
        %if B(1)>=0
            %B(1)=0;
        %else
            %B(1)=abs(B(1));
        %end
        %E(i,5)=B(1);
    %end
    %for i=1:size
        %if E(i,4)<1e-6
            %E(i,3)=fmax+E(i,5);
        %end
    %end       
    [Q,IX]=sort(E,1);
    %Q=vpa(Q,4);%%
    D(g,1)=Q(1,4); %��¼ÿ��������ֵ
    D(g,2)=mean(Q(:,4));
    D(g,3)=Q(size,4); 
    %D(g,4)=E(IX(1,3),4);
    if Q(1,4)<fv 
        xm=E(IX(1,4),(1:3));
        fv=Q(1,4);
        %xm=[xm,E(IX(1,3),4)];
        saveinventory=vpa(E(IX(1,3),2)*Dcoe*sqrt(a*(b-E(IX(1,3),1))^2+c),6);% ���㰲ȫ���;
    end
end

%��ͼ
t=1;
for i=20:NP
    %if D(i,4)==1
        N(t,:)=D(i,:);
        t=t+1;
    %end
end
        
plot(N(:,1),'r*');
hold on
plot(N(:,2),'b+');
hold on
plot(N(:,3),'ms');
legend('����ֵ','ƽ��ֵ','���ֵ');
hold off
D
end
   


 