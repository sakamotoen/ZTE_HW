%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3D波束形成 FFT算法
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;
f=60*10^3;
fs=5*f;
w=2*pi*f;
c=1500;
lmd=c/f;
d=lmd/2*2;
%d=0.015;
theti=10*pi/180;%入射信号的方位角0～180，与平面阵的夹角
faii=10*pi/180;%入射信号的俯仰角0～90，与水平夹角

%%
for ii=1:10
     for kk=1:10
        gx1=exp(j*(ii-1)*2*pi*d/lmd*sin(theti)*cos(faii));
        gz1=exp(j*(kk-1)*2*pi*d/lmd*(sin(faii)));
W(ii,kk)=gx1*gz1;
	 end
end
pfft=fftshift(fft2(W,128,128));
xx=linspace(-180,180,128)*pi/180;
yy=linspace(-180,180,128)*pi/180;
ux=sin(xx).*cos(yy);
uy=sin(xx).*sin(yy);
ux1=asin(xx*lmd/(2*pi*d));
uy1=asin(yy*lmd/(2*pi*d));
pfft=20*log((abs(pfft)/max(max(abs(pfft)))));
ind=find(pfft<=-40);
pfft(ind)=-40;
mesh(ux1*180/pi,uy1*180/pi,(pfft));grid on;
