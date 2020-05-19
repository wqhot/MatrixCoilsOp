clear;
R=61/1000;

%线圈半径
r=60/1000;
%默认匝数、电流、方向
global defaultN;
global defaultI;
global defaultd;
global tableN;
global tableFN;
defaultN=300;
defaultI=1;
defaultd=1;
tableN=[];
tableFN=[];
%上下级版距离
global LbtwUD;
LbtwUD=0.5*2;
%ROI区域参数
ROI_R=0.05;
ROI_d=0.01;
%CoilsMatrix=[2*60/1000*sqrt(2),pi/4,2*60/1000,2*60/1000,60/1000,300,1,1;2*60/1000*sqrt(2),pi/4,2*60/1000,2*60/1000,60/1000,300,1,1];
CoilsMatrix=[0,0,0,0,60/1000,1,1,1;0,0,0,0,60/1000,1,1,1];
ROI=createROI(ROI_R,'aa',ROI_d);
targetROI=createTargetROI(ROI,0,0.01);
%save 双线圈坐标.txt ROI -ascii
% tic;
% BSmag = BSmag_init();
% theta = linspace(-pi,pi,400);
% for i=1:size(CoilsMatrix,1)/2 
%     Gamma1 = [CoilsMatrix(i,3)+CoilsMatrix(i,5)*cos(theta'),CoilsMatrix(i,4)+CoilsMatrix(i,5)*sin(theta'),repmat(LbtwUD/2,size(theta'))];
%     I = CoilsMatrix(i,7)*CoilsMatrix(i,8)*CoilsMatrix(i,6); % filament current [A]
%     dGamma = 1e1; % filament max discretization step [m]
%     [BSmag] = BSmag_add_filament(BSmag,Gamma1,I,dGamma);
%     
%     Gamma2 = [CoilsMatrix(i+size(CoilsMatrix,1)/2,3)+CoilsMatrix(i+size(CoilsMatrix,1)/2,5)*cos(theta'),CoilsMatrix(i+size(CoilsMatrix,1)/2,4)+CoilsMatrix(i+size(CoilsMatrix,1)/2,5)*sin(theta'),-repmat(LbtwUD/2,size(theta'))];
%     I = CoilsMatrix(i+size(CoilsMatrix,1)/2,7)*CoilsMatrix(i+size(CoilsMatrix,1)/2,8)*CoilsMatrix(i+size(CoilsMatrix,1)/2,6); % filament current [A]
%     dGamma = 1e1; % filament max discretization step [m]
%     [BSmag] = BSmag_add_filament(BSmag,Gamma2,I,dGamma);
% end
% 
% % Field points (where we want to calculate the field)
% % x_M = linspace(-ROI_R,ROI_R,2*ROI_R/ROI_d+1); % x [m]
% % y_M = linspace(-ROI_R,ROI_R,2*ROI_R/ROI_d+1); % y [m]
% % z_M = linspace(-ROI_R,ROI_R,2*ROI_R/ROI_d+1); % z [m]
% % [X_M,Y_M,Z_M]=meshgrid(x_M,y_M,z_M);
% %BSmag_plot_field_points(BSmag,X_M,Y_M,Z_M); % shows the field points volume
% 
% % Biot-Savart Integration
% [BSmag,BX,BY,BZ] = BSmag_get_B(BSmag,ROI);
% %contourf(reshape(X(:,:,11),21,21), reshape(Y(:,:,11),21,21), reshape(BZ(:,:,11),21,21)), colorbar
% % contourf(reshape(Y(:,11,:),21,21), reshape(Z(:,11,:),21,21), reshape(BZ(:,11,:),21,21)), colorbar
% toc;
% figure(2), hold on, box on, grid on
% 	plot3(Gamma1(:,1),Gamma1(:,2),Gamma1(:,3),'.-r') % plot filament
% plot3(Gamma2(:,1),Gamma2(:,2),Gamma2(:,3),'.-r') % plot filament
% 	slice(X,Y,Z,BZ,[0],[],[0]), colorbar % plot Bz





%BsTest=ROIcalNew(ROI,CoilsMatrix,LbtwUD,100);
BsTestOld=ROIcal(ROI,CoilsMatrix,LbtwUD,2);

%plot(bbb(:,3),bbb(:,4));

shuru=importdata('双线圈磁场值1.txt');

bb=BsTestOld(find(abs(BsTestOld(:,1)-0.02)<eps),:);
bbb=bb(find(abs(bb(:,2)-0.02)<eps),:);
aaa1=shuru(find(abs(shuru(:,1)-0.02)<eps),:);
aaa=aaa1(find(abs(aaa1(:,2)-0.02)<eps),:);
%ccc=BZ(11,11,:);
figure;
hold on;
plot(aaa(:,3),aaa(:,4),'-');
plot(bbb(:,3),bbb(:,4),'*');

bili=[chazhi(:,1:3),abs(chazhi(:,4)./shuru(:,4))];
[bili,shunxu]=sortrows(bili,-size(bili,2));
newBsTest=BsTest(shunxu,:);
newShuru=shuru(shunxu,:);



shurubz=shuru(:,1:4);
chazhi=[shurubz(:,1:3),shurubz(:,4)-BsTest(:,4)];
X=[ones(size(chazhi,1),1),chazhi(:,1:3)];
[b,bint,r,rint,stats]=regress(chazhi(:,4),[X,X(:,2:4).^2]);
BsXiuzheng=b(1)+BsTest(:,1)*b(2)+BsTest(:,2)*b(3)+BsTest(:,3)*b(4)+BsTest(:,4)+...
    BsTest(:,1).^2*b(5)+BsTest(:,2).^2*b(6)+BsTest(:,3).^2*b(7);
chazhi2=[shurubz(:,1:3),shurubz(:,4)-BsXiuzheng];
drawHeatMap3D(chazhi2);



%plot(-ROI_R:ROI_d:ROI_R,ccc(:),'--');
% drawHeatMap3D(BsTest);
figure;
hold on;
for i=1:11
    plot(BZ(11,:,10+i));
end
 temp1=BsTest(find(BsTest(:,2)==0),:);
 figure;
 hold on;
for i=1:11
   temp2=temp1(find(temp1(:,3)==0+ROI_d*(i-1)),:);
   plot(temp2(:,1),temp2(:,4));
end

comsol=importdata('仿真结果.xlsx');

function2=[];
fangzhen=[];
for i=1:size(BsTest,1)
    xindex=floor((BsTest(i,1)+ROI_R)/ROI_d+1);
    yindex=floor((BsTest(i,2)+ROI_R)/ROI_d+1);
    zindex=floor((BsTest(i,3)+ROI_R)/ROI_d+1);
    function2=[function2;BsTest(i,1),BsTest(i,2),BsTest(i,3),BZ(xindex,yindex,zindex)];
    temp1=comsol(find(abs(comsol(:,1)-BsTest(i,1))<eps),:);
    temp2=temp1(find(abs(temp1(:,2)-BsTest(i,2))<eps),:);
    temp3=temp2(find(abs(temp2(:,3)-BsTest(i,3))<eps),4);
    fangzhen=[fangzhen;BsTest(i,1),BsTest(i,2),BsTest(i,3),temp3];
end