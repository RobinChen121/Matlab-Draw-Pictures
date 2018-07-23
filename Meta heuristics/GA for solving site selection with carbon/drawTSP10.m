function drawTSP10(Clist,BSF,qs,bsf,p,f)
CityNum=size(Clist,1)-1;
CarNum=size(qs,2)-1;
%col='gbymcwkgbymcwkgbymcwk';%�ò�ͬ��������ʻ·����ɫ��һ��
%line_s=struct('f',{'-','-','-','--','-',':','--','-.'});
line_c=[0.8,2,3.5,0.8,2,3.5,0.8,2,3.5,0.8,2,3.5,0.8,2,3.5];
scatter(Clist(1:CityNum,1),Clist(1:CityNum,2),'k');
hold on;
for i=1:CityNum
    text(Clist(i,1)+2,Clist(i,2)+2,num2str(i));  %��ͼ���ˣ�����û��
end
for j=1:CarNum
    %annotation('arrow',[Clist(CityNum+1,1),Clist(BSF(qs(j)),1)]/200,[Clist(CityNum+1,2),Clist(BSF(qs(j)),2)]/200,'LineStyle','-');
    %text([Clist(CityNum+1,1),Clist(BSF(qs(j)),1)],[Clist(CityNum+1,2),Clist(BSF(qs(j)),2)],'chen zhen');
    plot([Clist(CityNum+1,1),Clist(BSF(qs(j)),1)],[Clist(CityNum+1,2),Clist(BSF(qs(j)),2)],strcat('k',':'),'LineWidth',line_c(j))
    hold on;
    for i=qs(j):qs(j+1)-2
        %annotation('arrow',[Clist(BSF(i),1),Clist(BSF(i+1),1)]/200,[Clist(BSF(i),2),Clist(BSF(i+1),2)]/200,'LineStyle','-')
        plot([Clist(BSF(i),1),Clist(BSF(i+1),1)],[Clist(BSF(i),2),Clist(BSF(i+1),2)],strcat('k','-'),'LineWidth',line_c(j));
        hold on;
    end
    %annotation('arrow',[Clist(BSF(qs(j+1)-1),1),Clist(CityNum+1,1)]/200,[Clist(BSF(qs(j+1)-1),2),Clist(CityNum+1,2)]/200,'LineStyle','-')
    plot([Clist(BSF(qs(j+1)-1),1),Clist(CityNum+1,1)],[Clist(BSF(qs(j+1)-1),2),Clist(CityNum+1,2)],strcat('k','-'),'LineWidth',line_c(j));
end
hold on;
plot(Clist(CityNum+1,1),Clist(CityNum+1,2),'ks','MarkerSize',13);
%axis([0,1,0,1]);
title([num2str(CityNum),'����TSP']);
%legend('��һ����','�ڶ�����','��������');
hold off;
%if f==0
   % text(1,1,['�� ',int2str(p),' ��','  ��С����Ϊ ',num2str(bsf,5),' Ԫ']);
%else
   % text(1,1,['���������������С���� ',num2str(bsf,5),' Ԫ']);
%end
pause(0.05); 