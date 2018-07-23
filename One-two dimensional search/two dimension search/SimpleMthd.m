function [x,minf]=SimpleMthd(A,c,b,baseVector)  %%������������Թ滮
%Լ������A;
%Ŀ�꺯��ϵ��������c;
%Լ���Ҷ�������b;
%��ʼ��������baseVector
%Ŀ�꺯��ȡ��Сֵʱ���Ա���ֵ��x;
%Ŀ�꺯������Сֵ��minf

sz=size(A);%Լ����������������
nVia=sz(2);
n=sz(1);
xx=1:nVia;
nobase=zeros(1,1);
m=1;

if c>=0
    vr=find(c~=0,1,'last');
    rgv=inv(A(:,(nVia-n+1):nVia)*b;
    if rgv>=0
        x=zeros(1,vr);
        minf=0;
    else
        disp('���������Ž�');
        x=NaN;
        minf=NaN;
        return;
    end
end

for i=1:nVia
    if (isempty(find(baseVector==xx(i),1)))%��ȡ�ǻ������±�
        nobase(m)=i;
        m=m+1;
    end
end
bCon=1;
M=0;

while bCon==1
    nB=A(:,nobase);%�ǻ���������
    ncb=c(nobase);%�ǻ�����ϵ��
    B=A(:,baseVector);%����������
    cb=c(baseVector);%������ϵ��
    xb=inv(B)*b; %������Ļ���������
    f=cb*xb;%�������Ŀ�꺯��ֵ
    w=cb*inv(B);%�����Գ���
    
    for i=1:length(nobase)  % �б�
        sigma(i)=w*nB(:,i)-ncb(i);
    end
    [maxs,ind]=max(sigma); %�б�ϵ�������ֵ��indΪ���������±�
    if maxs<=0    %���ֵС��0��������Ž�
        minf=cb*xb;
        vr=find(c~=0,1,'last');
        for l=1:vr
            ele=find(baseVector==l,1);
            if(isempty(ele))
                x(l)=0;
            else
                x(l)=xb(ele);%�õ����Ž�
            end
        end
        bCon=0;
    else
        y=inv(B)*A(:,nobase(ind));
        if y<=0
            disp('���������Ž�');
            x=NaN;
            minf=NaN;
            return;
        else    %Ѱ�ҳ�������
            minb=inf;
            chagB=0;
            for j=1:length(y)
                if y(j)>0
                    bz=xb(j)/y(j);
                    if bz<minb
                        minb=bz;
                        chagB=j;
                    end
                end
            end %chagBΪ���������±�
            tmp=baseVector(chagB);%���»�����ͷǻ�����
            baseVector(chagB)=nobase(ind);
            nobase(ind)=tmp;
        end
    end
    M=M+1;
    if (M==1000000)
        disp('�Ҳ������Ž⣡');
        x=NaN;
        minf=NaN;
        return;
    end
end



        
