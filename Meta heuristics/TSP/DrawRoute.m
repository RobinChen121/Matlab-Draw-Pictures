function m=DrawRoute(Clist,BSF,bsf,p)
CityNum=size(Clist,1);
for i=1:CityNum-1
    plot([Clist(BSF(i),1),Clist(BSF(i+1),1)],[Clist(BSF(i),2),Clist(BSF(i+1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');%��ֱ�߽�����������
    hold on;  % ������ͬһ����ϵ���Ʋ�ͬ��ͼ��
end
plot([Clist(BSF(CityNum),1),Clist(BSF(1),1)],[Clist(BSF(CityNum),2),Clist(BSF(1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
title([num2str(CityNum),'����TSP']);
text(5,5,['�� ',int2str(p),' ��','  ��̾���Ϊ ',num2str(bsf)]);
hold off;
pause(0.05); %matlabִ��������ʱ�䣬�ܹ���ʾ��̬Ч��
