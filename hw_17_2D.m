%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2D波束形成 LCMV算法
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; 
close all
clear all; 

M=10;                                     % 天线数量
L=500;                                    % 在计算中使用了多少个采样点，暂时定为500个 
thetas=10;                                % 信号入射角度 
thetai=[-30 30];                          % 干扰入射角度 
n=[0:M-1]';                               % 构造一个一维列矩阵 

vs=exp(-j*pi*n*sin(thetas/180*pi));       % 信号方向矢量 
vi=exp(-j*pi*n*sin(thetai/180*pi));       % 干扰方向矢量 

f=16000;                                  % 信号频率
t=[0:1:L-1]/200;                          % 构造时间变量
snr=10;                                   % 信噪比 
inr=10;                                   % 干噪比

%构造有用信号 
xs=sqrt(10^(snr/10))*vs*exp(j*2*pi*f*t);  
%构造干扰信号
xi=sqrt(10^(inr/10)/2)*vi*[randn(length(thetai),L)+j*randn(length(thetai),L)];
%产生噪声
noise=[randn(M,L)+j*randn(M,L)]/sqrt(2); 

X=xi+noise;                              % 构造出来的含噪声的接收到的信号
R=X*X'/L;                                % LCMV 方法中的 R 矩阵
wop1=inv(R)*vs/(vs'*inv(R)*vs);          % 这里直接套用 LCMV 计算公式
sita=48*[-1:0.001:1];                    % 扫描方向范围
v=exp(-j*pi*n*sin(sita/180*pi));         % 扫描方向矢量 
B=abs(wop1'*v);                          % 求不同角度的增益
plot(sita,20*log10(B/max(B)),'k'); 
title('波束图');xlabel('角度/degree');ylabel('波束图/dB'); 
grid on 
axis([-48 48 -50 0]); 
hold off
