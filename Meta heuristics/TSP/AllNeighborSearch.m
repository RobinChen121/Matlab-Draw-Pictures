function AllNeighborSearch(C)
%%% author: Chen Zhen
%%% ����������г�����ѡȡ��һ��������Ϊ��ʼ��
    if nargin<1,
       error('There are no input data!')
    end
    if ~isnumeric(C),
        error('The array C must be numeric!') 
    end
    if ~isreal(C),
        error('The array C must be real!') 
    end
    s=size(C); % size of array C
    if length(s)~=2,
        error('The array C must be 2D!') 
    end
    if s(1)<3,
        error('Must be not less than 3 cities!')
    end
tic; % �������ִ������ʱ��
CityNum= size(C,1);
DistanceList=zeros(CityNum,CityNum);
for i=1:CityNum     % �����м����������
    for j=1:CityNum
        DistanceList(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;
    end
end

S0=[1,randperm(CityNum-1)+1]
Distance0=CalDistance(DistanceList,S0); % �����ʼ·���ľ���
S=zeros(1,CityNum);
S=S0;%��ʼ��
Distance=Distance0;%��ʼ����
NeighborNum=ceil((CityNum-1)*(CityNum-2)/2);%�ھ���Ŀ
Neighbor=zeros(NeighborNum,CityNum);%����
Swap=zeros(NeighborNum,2);%2-opt���򽻻�����
a=1;
lx=50; % ÿ���ֲ�����ĵ�������

for i=1:CityNum     % ��ʾ2-opt�������еĽ�������
    Swap(a:a+CityNum-i-2,1)=i+1;
    Swap(a:a+CityNum-i-2,2)=i+2:CityNum;
    a=a+CityNum-i-1;
end

step=1;% ��������
while Distance<=Distance0
    PresentDistance(step)=CalDistance(DistanceList,S);%�Ե�ǰ·������洢
    PresentRoute(step,:)=S;
    for i=1:NeighborNum   % �Գ�ʼ·���Ľڵ��ý����������
        Neighbor(i,:)=S;
        Neighbor(i,Swap(i,1))=S(1,Swap(i,2));
        Neighbor(i,Swap(i,2))=S(1,Swap(i,1));
    end
    D=zeros(NeighborNum,2);
    for i=1:NeighborNum   % ������������·���ľ���
        D(i,1)=i;
        D(i,2)=CalDistance(DistanceList,Neighbor(i,:));
    end
    [B,IX]=sort(D(:,2)); % ��·�����밴��С��������
    if B(1)<Distance
        Distance=B(1);
        BetterDistance(step)=Distance;%�ԸĽ�·��������д洢
        S=Neighbor(IX(1),:); 
        step=step+1;
    else
        BetterDistance(step)=Distance;
        Route=S
        ShortDistance=Distance
        break
    end
end
toc % �������ִ������ʱ��
for i=1:step
    DrawRoute(C,PresentRoute(i,:),PresentDistance(i),i); % ��·���仯���̻�ͼ
end
figure(2); % �Ծ���仯���̻�ͼ
plot(BetterDistance,'r'); hold on;
plot(PresentDistance,'b');
title('��������');
legend('�Ľ���','��ǰ��');
hold off;
end
