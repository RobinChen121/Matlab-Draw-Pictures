function carbon_ga(CityNum,shu)
%%shu=1��ʾ����̼�ɱ���shu=0��ʾ������̼�ɱ�
    [dislist,Clist]=tsp1(CityNum);
    DD=demand(CityNum);
global C
global n
global pc
global pm
global inn
global g
global P
global miu
global cishu
global M
global G_M
global G_M0
global carbon_per;
global tax
global a %%����ɱ�����

inn=100; %��ʼ��Ⱥ��С
gnmax=100;  %������
if CityNum==10
    C=10;
else
	C=20; %ÿ������������
end
g=50000;%ÿ�����Ĺ̶���Ӫ�ɱ�
P=150; %̼�����
M=1000;% ̼�ŷ��޶�
G_M=500;%ÿ��Ĺ̶�̼�ŷ�������λ��
G_M0=350;
n=floor(sum(DD)/C)+1; %������
miu=7.7; %�ͼ� 
cishu=50; %���˻�����
pc=0.8; %�������
pm=0.02; %�������
carbon_per=3.0772;%̼�ŷ�ϵ��  kg/
tax=200; %̼˰�۸�
a=5000;
 
ymax=zeros(gnmax,1);%������¼ÿ��������ֵ
ymean=zeros(gnmax,1);%������¼ÿ����ƽ��ֵ
smax=zeros(gnmax,CityNum);%������¼ÿ�������Ž�
kx_n=zeros(gnmax,1);%������¼ÿ�����Ž��Ƿ�Ϊ���н�
qs_n=zeros(gnmax,n+1);%������¼ÿ�����Ž�ĳ����ĳ�����
load_n=zeros(gnmax,CityNum+1);%������¼ÿ�����Ž�ĸ�·������
Tgc_n=zeros(gnmax,1);%������¼ÿ�����Ž��̼�ŷ���

%������ʼ��Ⱥ
s=zeros(inn,CityNum);
tt=zeros(inn,1); %��¼��Ӧ��
kx=zeros(inn,1);%��¼�ǲ��ǿ��н�
over=zeros(inn,1);%��¼�ǿ��н�ĳ�����
qs=zeros(inn,n+1);%������¼ÿ�������ĳ���������ֹ���
load=zeros(inn,CityNum+1);%������¼��·������
Tgc=zeros(inn,1);

for i=1:inn
    s(i,:)=randperm(CityNum);
    [tt(i),kx(i),qs(i,:),over(i),load(i,:)]=tcost(s(i,:),dislist,DD,shu);  %�õ�ÿ����Ⱥ����Ӧֵ������¼�Ƿ���н�
end   %load������
%%�޸ķǿ��н����Ӧֵ���������ۼƸ���
max=0; %����Ѱ�ҿ��н����Сֵ
for i=2:inn
    if  max<tt(i)&&kx(i)==1
        max=tt(i);
    end
end
for i=1:inn
    if kx(i)==0
        tt(i)=max+over(i)*tt(i)/C;%%�޸ķǿ��н�
    end
end
[BB,idx]=sort(tt,1);
 %%��ʼ�����ۼƸ���,�����̶ķ���ѡ��
sumb=sum(BB);
pp=zeros(inn,1);
pp(1)=BB(1)/sumb;
smnew=zeros(inn,CityNum);%������¼�¾���
 for i=1:inn-1
     pp(i+1)=BB(i+1)/sumb+pp(i); 
 end
%%�Ŵ�����
gn=1;
ymax(gn)=BB(1);
smax(gn,:)=s(idx(1),:);

while gn<gnmax+1
    for i=1:2:inn
        seln1=sel(s,idx,pp);  %ѡ����
        seln2=sel(s,idx,pp);  %ѡ��ĸ��
        scro=cro(s,seln1,seln2,pc);  %�������
        smnew(i,:)=mut(scro(1,:),pm);  %�������
        smnew(i+1,:)=mut(scro(2,:),pm);
    end
   s=smnew;  %�������µ���Ⱥ
   %%��������Ⱥ��Ӧֵ
   for i=1:inn
    s(i,:)=randperm(CityNum);
    [tt(i),kx(i),qs(i,:),over(i),load(i,:),Tgc(i,:)]=tcost(s(i,:),dislist,DD,shu);  %�õ�ÿ����Ⱥ����Ӧֵ������¼�Ƿ���н�
   end
    %%�޸ķǿ��н����Ӧֵ���������ۼƸ���
    max=0; %����Ѱ�ҿ��н�����ֵ
    for i=1:inn
        if  max<tt(i)&&kx(i)==1
            max=tt(i);
        end
    end
    for i=1:inn
        if kx(i)==0
            tt(i)=max+over(i)*tt(i)/C;
        end
    end
    [BB,idx]=sort(tt,1);
    %%��ʼ�����ۼƸ���,�����̶ķ���ѡ��
    sumb=sum(BB);
    pp=zeros(inn,1);
    pp(1)=BB(1)/sumb;
    smnew=zeros(inn,CityNum);
    for i=1:inn-1
        pp(i+1)=BB(i+1)/sumb+pp(i); 
    end
    %��¼��ǰ������Ѹ���
    ymax(gn)=BB(1);
    ymean(gn)=mean(BB(:,1));
    smax(gn,:)=s(idx(1),:);
    qs_n(gn,:)=qs(idx(1),:);
    kx_n(gn,:)=kx(idx(1),:);
    load_n(gn,:)=load(idx(1),:);
    Tgc_n(gn,:)=Tgc(idx(1),:);
    drawTSP10(Clist,smax(gn,:),qs(gn,:),ymax(gn),gn,0);
    gn=gn+1;
end
[BB,idx]=sort(ymax,1);
drawTSP10(Clist,smax(idx(1),:),qs_n(idx(1),:),ymax(idx(1)),idx(1),1);
smaxx=smax(idx(1),:);
load_nn=load_n(idx(1),:);
disp('��ʼ�㣺');
qs_nn=smaxx(qs_n(idx(1),1:n))
disp('�����е�̼�ŷ�����');
Tgc_nn=Tgc_n(idx(1),:)
disp('̼���׳ɱ���');
P*(Tgc_nn-M)
disp('̼˰�ɱ���');
tax*Tgc_nn
disp('�����ܳɱ�');
BB(1)
disp('̼˰�ܳɱ�');
BB(1)-P*(Tgc_nn-M)+tax*Tgc_nn


figure(2);
plot(ymax,'r'); hold on;
plot(ymean,'b');grid; %%grid��Ϊ����ʾ������
title('��������');
legend('���Ž�','ƽ����');
end

function [tt1,kx,qs,over,load,Tgc]=tcost(s,dislist,DD,shu)  %������Ӧֵ
    m=1; %��¼���ó�����
    global n
    global C
    global miu
    global g
    global cishu
    global M
    global P
    global tax
    global carbon_per
    global G_M
    global G_M0
    global a
    qs=zeros(1,n+1);%��¼������ʼ�� 
    gf=zeros(1,n);%��¼ÿ���������ͺĳɱ�
    gc=zeros(1,n);%��¼ÿ������̼�ŷ���
    CityNum=size(DD,2);
    sum1=0;
    qs(m)=1;%��һ��������ʼ��Ϊ��һ����
    qs(n+1)=CityNum+1;%���һ������ʻ�����һ����
    for j=1:CityNum
        sum1=DD(s(j))+sum1;
        if sum1>C && m<n   %%�жϿ��н��е�����,û����
            sum1=DD(s(j));
            m=m+1;
            qs(m)=j;
        end
    end
    load=zeros(1,CityNum+1);%������ʻ��ÿ��·���ϳ�����������
    m=1;
    for i=1:CityNum
        load(i)=sum(DD(s(qs(m):qs(m+1)-1)))-sum(DD(s(qs(m):i-1))); %û������
       if i+1>=qs(m+1)&&m<n
            m=m+1;
        end
    end
    m=1;
    while m<n+1
          sum11=miu*dislist(s(qs(m+1)-1),CityNum+1)*fuel_quantity(0)+miu*dislist(CityNum+1,qs(m))*fuel_quantity(load(qs(m)));       
          sum12=carbon_per*dislist(s(qs(m+1)-1),CityNum+1)*fuel_quantity(0)+2.6754*dislist(CityNum+1,qs(m))*fuel_quantity(load(qs(m)));
          for j=qs(m):qs(m+1)-2
              sum11=miu*dislist(s(j),s(j+1))*fuel_quantity(load(j+1))+sum11;%��¼����������·�ε��ܳɱ�
              sum12=carbon_per*dislist(s(j),s(j+1))*fuel_quantity(load(j+1))+sum12;%��¼����������·�ε���̼�ŷ���    
          end
          gf(m)=sum11;
          gc(m)=sum12/1000; %����λ��Ϊ��
          m=m+1;
    end
    Tgc=cishu*sum(gc); % sum(gc)Ϊ������̼�ŷ���
    tt1=cishu*sum(gf)*miu+n*g;
    if shu==1
        tt2=P*max((cishu*sum(gc)+G_M-M),0);
    end
    if shu==0
        tt2=0;
    end
    if shu==1
        tt2=tax*max((cishu*sum(gc)+G_M),0);
    end
    if shu==0
        tt2=0;
    end
    tt=tt1+tt2;
    if load(qs(m-1))<=C  %%�����⣬�ٸ��Ⱥ�
        kx=1; 
        over=0;
    else
        kx=0;
        over=load(qs(m-1))-C;
    end
end

function ff=fuel_quantity(load) %�����������ĺ���
    global C
    if C==20
        ff=10.2181+1.021*load-1.1247*10^(-5)*load^2;
    else
        ff=6.5526+1.2154*load-3.5404*10^(-6)*load^2;
    end
end

function seln=sel(s,idx,pp) %ѡ��
ppr=rand;
global inn
    for j=1:inn
        if pp(j)>=ppr
            seln(1,:)=s(idx(j),:);  %ѡ����
            break
        end
    end
end

function scro=cro(s,seln1,seln2,pc)
bn=size(s,2); %������
scro(1,:)=seln1;
scro(2,:)=seln2;%������¼������·��
if rand<=pc
   c1=round(rand*(bn-2))+1;  %��[1,bn-1]��Χ���������һ������λ
   c2=round(rand*(bn-2))+1;
   chb1=min(c1,c2);
   chb2=max(c1,c2);
   middle=scro(1,chb1+1:chb2);
   scro(1,chb1+1:chb2)=scro(2,chb1+1:chb2);
   scro(2,chb1+1:chb2)=middle;
   for i=1:chb1       %���ظ��ĵ㣬�滻��
       for j=chb1+1:chb2
           if scro(1,j)==scro(1,i)
              scro(1,i)=scro(2,j);
           end
           if scro(2,j)==scro(2,i)
              scro(2,i)=scro(1,j);
           end
       end
   end
   for i=chb2+1:bn
       for j=1:chb2
           if scro(1,j)==scro(1,i)
              scro(1,i)=scro(2,j);
           end
           if scro(2,j)==scro(2,i)
              scro(2,i)=scro(1,j);
           end
       end
   end
end
end

%�����족����
function snnew=mut(snew,pm)

bn=size(snew,2);
snnew=snew;
if rand<pm
   c1=round(rand*(bn-2))+1;  %��[1,bn-1]��Χ���������һ������λ
   c2=round(rand*(bn-2))+1;
   chb1=min(c1,c2);
   chb2=max(c1,c2);
   x=snew(chb1+1:chb2);
   snnew(chb1+1:chb2)=fliplr(x);%���ⲿ�ֵ���
end
end

