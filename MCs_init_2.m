clc;
clear;
tic;
%上下极板半径
R=250/1000;

%线圈半径
r=20/1000;
%默认匝数、电流、方向
global defaultN;
global defaultI;
global defaultd;
global tableN;
global tableFN;
defaultN=9;
defaultI=3000;
defaultd=1;
tableN=[];
tableFN=[];
%上下级版距离
global LbtwUD;
LbtwUD=15/1000;
%ROI区域参数
ROI_R=0.05;
ROI_d=0.005;
CoilsMatrix=numOfCoils(R,r);

for i=1:size(CoilsMatrix,1)
    k=size(CoilsMatrix,1)-i+1;
    polar(CoilsMatrix(k,2),CoilsMatrix(k,1),'*');
    hold on;
end
toc;
%ROI区域设置
ROI=createROI(ROI_R, 'aa', ROI_d);
targetROI=createTargetROI(ROI, 2, 0.01);
toc;
%Bs=ROIcal(ROI,CoilsMatrix,LbtwUD,2);
%finalCoilsMatrix=GAopt(CoilsMatrix,ROI,0.66,0.1,100,1000,1000,targetROI);
shouliansudu=zeros(20, 1000);
for i=1:size(shouliansudu, 1)
    finalCoilsMatrix=PSOopt(CoilsMatrix, ROI, 100, 1000, 1000000, targetROI);
    shouliansudu(i,:)=finalCoilsMatrix;
end

for i=1:10
    plot(shouliansudu(i,1:25));
  
    hold on;
end
% legend(legends(1),legends(2),legends(3),legends(4),legends(5),legends(6),legends(7),legends(8),legends(9),legends(10));
xlswrite('粒子群收敛速度.xlsx',shouliansudu);
%画图
% testCoilsMatrix=CoilsMatrix;
% testCoilsMatrix(:,6)=finalCoilsMatrix(1,1:end-1)';
% BsTest=ROIcalNew(ROI,testCoilsMatrix,LbtwUD,400);
% saveMat=testCoilsMatrix(:,6);
% save 线圈.txt saveMat -ascii
% drawHeatMap3D(BsTest);