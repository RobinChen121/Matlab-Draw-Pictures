function [xm,fv]=GAEOQ2
%%��ʼĿ�꺯����Լ������
syms t k z;
f=100/t+25*(25*t+k*10*sqrt(1.25*t))+1000*sqrt(1.25*t)*int(normpdf(z,0,1),z,k,inf)/t;
tmin=4;
tmax=6;
kmin=0;
kmax=2;
g1=0.05-10*sqrt(2+0.75*t)*int((z-k)*normpdf(z,0,1),z,k,inf)/(50*t);%%��Լ����׼������Ϊ3��Լ��������ͬ���ʲ��ر�׼��
NP=50; %�������ٴ�

%%��ʼ����Ⱥ����Ⱥ����40
size=20;
E=zeros(20,5); %ǰ����Ϊ��ʼ�⣬������Ϊ��Ӧ����ֵ�������м�¼�Ƿ�Ϊ���н⣬�����м�¼Υ��Լ�������Ĳ�ֵ
E(:,1)=tmin+(tmax-tmin)*rand(size,1);
E(:,2)=kmin+(kmax-kmin)*rand(size,1);
fv=inf;%��ʼ����ֵΪ������ֵ
D=zeros(NP,4);%������¼ÿ�������Ž�,ƽ��ֵ������,���Ž��Ƿ�Ϊ���н�

%%������Ӧ����������ֵ���ж��Ƿ�Ϊ���н�
for i=1:size
    B=zeros(1,1);
    B(1)=subs(g1,[t,k],E(i,(1:2)));
    if B(1)>=0
       E(i,4)=1;
       E(i,3)=subs(f,[t,k],E(i,(1:2)));
    else
       E(i,4)=0;
       E(i,3)=0;
    end
    if B(1)>=0
       B(1)=0;
    else
       B(1)=abs(B(1));
    end
    E(i,5)=B(1);
end
fmax=max(E(:,3));
for i=1:size
if E(i,4)<1e-6
   E(i,3)=fmax+E(i,5);
   end
end

%%�Ŵ�����
for k=1:NP 
    %%������ѡ��  %%С��̬����
    M=zeros(size,2);%�����洢��ʤ�ߵ��м����
        for i=1:size
            A=randperm(size,2);
            if E(A(1),3)<=E(A(2),3)
                M(i,:)=E(A(1),(1:2));
            else
                M(i,:)=E(A(2),(1:2));
            end 
        end

    %%ģ������ƽ������ɺ��
        for j=1:size/2
            if rand()>=0.5
                A=randperm(size,2);
                c=rand();
                x2=max(M(A(1),1),M(A(2),1));
                x1=min(M(A(1),1),M(A(2),1));
                beita1_t=1+2*(x1-tmin)/(x2-x1);
                rfa_t=2-beita1_t^(-2);
                if c<=1/rfa_t
                    beita2_t=sqrt(rfa_t*c);
                else
                    beita2_t=sqrt(1/(2-rfa_t*c));
                end
                E(2*j-1,1)=0.5*(x1+x2-beita2_t*(x2-x1));
                E(2*j,1)=0.5*(x1+x2+beita2_t*(x2-x1));
            end
    %%ֻ�ڿ��н�ʱ��������ô���£��ǲ��Ǳ����ԭ��
            if rand()>0.5
                c=rand();
                x2=max(M(A(1),2),M(A(2),2));
                x1=min(M(A(1),2),M(A(2),2));
                beita1_t=1+2*(x1-kmin)/(x2-x1);
                rfa_t=2-beita1_t^(-2);
                if c<=1/rfa_t
                    beita2_t=sqrt(rfa_t*c);
                else
                    beita2_t=sqrt(1/(2-rfa_t*c));
                end
                E(2*j-1,2)=0.5*(x1+x2-beita2_t*(x2-x1));
                E(2*j,2)=0.5*(x1+x2+beita2_t*(x2-x1));
            end
        end

        %%���죬����᲻�ᵼ�¿��нⲻ����?���½�ʱ���ñ���
        %for i=1:size
            %nita=100+k;
            %pm=1/size+k*(1-1/size)/NP;
            %if rand()<pm
            %u=rand();
            %x=E(i,1);
            %deltamax=tmax-tmin;
            %delta_1=min(x-tmin,tmax-x)/(tmax-tmin);
            %if u<=0.5
               % delta_2=(2*u+(1-2*u)*(1-delta_1)^(1/(nita+1)))^(1/(nita+1))-1;
            %else
               % delta_2=1-(2*(1-u)+2*(u-0.5)*(1-delta_1)^(nita+1))^(1/(nita+1));
            %end
            %E(i,1)=x+delta_2*deltamax;
           % end
    
            %if rand()<pm
            %u=rand();
            %x=E(i,2);
            %deltak_1=
            %if u<=0.5
                %delta_1=(2*u)^(1/(nita+1))-1;
            %else
                %delta_1=1-(2*(1-u))^(1/(nita+1));
            %end
            %E(i,2)=x+delta_1*deltamax;
            %end
        %end
    %%�����Ӵ�������ֵ���ж��Ƿ�������н� 
    for i=1:size
        B(1)=subs(eval(g1),[t,k],E(i,(1:2)));
        if B(1)>=0
            E(i,4)=1;
            E(i,3)=subs(eval(f),[t,k],E(i,(1:2)));
        else
            E(i,4)=0;
            E(i,3)=0;
        end
        if B(1)>=0
            B(1)=0;
        else
            B(1)=abs(B(1));
        end
        E(i,5)=B(1);
    end
    for i=1:size
        if E(i,4)<1e-6
            E(i,3)=fmax+E(i,5);
        end
    end
    [Q,IX]=sort(E,1);
    D(k,1)=Q(1,3);
    D(k,2)=mean(Q(:,3));
    D(k,3)=Q(size,3); 
    D(k,4)=E(IX(1,3),4);
    if Q(1,3)<fv && D(k,4)==1
        fv=Q(1,3);
        xm=E(IX(1,3),(1:2));
        xm=[xm,E(IX(1,3),4)];
    end
end

%��ͼ
k=1;
for i=1:NP
    if D(i,4)==1
        N(k,:)=D(i,:);
        k=k+1;
    end
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
   


 