%% ����ROI�����еĴŸ�Ӧǿ��
% x,y,z:Ŀ��λ������
% coilsMatrix:������Ȧ��������
% L:���¼������
% n:��⾫��
%%
function Bs=ROIcalofTMS(ROI,CoilsMatrix,LbtwUD,n)
%     sx=min(ROI(:,1));
%     ex=max(ROI(:,1));
%     sy=min(ROI(:,2));
%     ey=max(ROI(:,2));
%     sz=min(ROI(:,3));
%     ez=max(ROI(:,3));
%     sx1=min(ROI(find(ROI(:,1)~=sx),1));
%     ROI_d=sx1-sx;
    
    %���٣��ԳƵľͲ�����
    
%     saveCoilsMatrix=CoilsMatrix;
%     CoilsMatrix=CoilsMatrix(1:size(CoilsMatrix,1)/4,:);
    
    BSmag = BSmag_init();
    theta = linspace(-pi,pi,n);
    for i=1:size(CoilsMatrix,1)
        Gamma1 = [CoilsMatrix(i,3)+CoilsMatrix(i,5)*cos(theta'),CoilsMatrix(i,4)+CoilsMatrix(i,5)*sin(theta'),repmat(LbtwUD/2,size(theta'))];
        I = CoilsMatrix(i,7)*CoilsMatrix(i,8)*CoilsMatrix(i,6); % filament current [A]
        dGamma = 1; % filament max discretization step [m]
        [BSmag] = BSmag_add_filament(BSmag,Gamma1,I,dGamma);
    end
    % Field points (where we want to calculate the field)
%     x_M = linspace(sx,ex,(ex-sx)/ROI_d+1); % x [m]
%     y_M = linspace(sy,ey,(ey-sy)/ROI_d+1); % y [m]
%     z_M = linspace(sz,ez,(ez-sz)/ROI_d+1); % z [m]
%     [X_M,Y_M,Z_M]=meshgrid(x_M,y_M,z_M);
    
    
    [BSmag,BX,BY,BZ] = BSmag_get_B(BSmag,ROI);
%     middle=floor((size(z_M,2)+1)/2);
    %contourf(reshape(X(:,:,middle),(size(z_M,2)+1),(size(z_M,2)+1)), reshape(Y(:,:,middle),(size(z_M,2)+1),(size(z_M,2)+1)), reshape(BZ(:,:,middle),(size(z_M,2)+1),(size(z_M,2)+1))), colorbar
    
    %���ٸ�ԭ
    %x-y����������ȣ������෴
    %�����෴
    Bs=[ROI,BZ];
%     Bs2=[ROI,zeros(size(BZ))];
%     for i=1:size(Bs,1)
%         temp=Bs(Bs(:,2)==Bs2(i,2),:);
%         temp1=temp(temp(:,3)==Bs2(i,3),:);
%         Bs2(i,4)=-temp1(temp1(:,1)==-Bs2(i,1),4);
%     end
%     Bs(:,4)=Bs(:,4)+Bs2(:,4);
%     %�������
%     Bs2=[ROI,zeros(size(BZ))];
%     for i=1:size(Bs,1)
%         temp=Bs(Bs(:,1)==Bs2(i,1),:);
%         temp1=temp(temp(:,2)==Bs2(i,2),:);
%         Bs2(i,4)=temp1(temp1(:,3)==-Bs2(i,3),4);
%     end
%     Bs(:,4)=Bs(:,4)+Bs2(:,4);



%     for i=1:size(Bs,1)
%         xindex=floor((Bs(i,1)+ex)/ROI_d+1);
%         yindex=floor((Bs(i,2)+ey)/ROI_d+1);
%         zindex=floor((Bs(i,3)+ez)/ROI_d+1);
%         Bs(i,4)=BZ(xindex,yindex,zindex);
%     end
    %     Bs=[ROI,zeros(size(ROI,1),1)];
%     for i=1:size(ROI,1)
%         Bs(i,4)=allCoilsBz(Bs(i,1),Bs(i,2),Bs(i,3),coilsMatrix,L,n);       
%     end

end