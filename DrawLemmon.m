% draw a lemmon picture

close all;
clear all;
clc;
x=-0.5:0.05:1.05;
r=real(sqrt(x.^3.*(1-x).^3));
[a,b,c]=cylinder(r,30);
c=c*0.75;
figure(),title('Lemon Surface');
hSurface=surfl(a,b,c);%ע��surfl()����ָ�����յ�Ч��
rotate(hSurface,[1 0 0],90);
 shading interp
light('Position',[0 0 1],'Style','local')%ָ����Դ��λ�ã����䷽ʽ
set(hSurface,'FaceColor',[1,1,0],'FaceAlpha',0.75);
axis equal tight vis3d  %�趨���������ʽ