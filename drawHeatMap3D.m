function drawHeatMap3D(ROI)
%     figure('name','磁场分布');
%     jetColorMap=colormap(jet(1001));
%     maxROI=max(ROI(:,4));
%     minROI=min(ROI(:,4));
%     if maxROI==minROI
%         minROI=0;
%     end
%     standardROI=floor((ROI(:,4)-minROI)*1000./(maxROI-minROI))+1;
%     
%     for i=1:size(ROI,1)
%         
%         selectedColor = jetColorMap(standardROI(i),:);
%         plot3(ROI(i,1),ROI(i,2),ROI(i,3),'.','color',selectedColor);
%         hold on;
%     end
%     axis equal;
%     xlabel('X轴');
%     ylabel('Y轴');
%     zlabel('Z轴');
%     hold off;
    MAX_GRID=600;
    %ROI(:,1:3)=floor(ROI(:,1:3));
    sx=min(ROI(:,1));
    ex=max(ROI(:,1));
    sy=min(ROI(:,2));
    ey=max(ROI(:,2));
    sz=min(ROI(:,3));
    ez=max(ROI(:,3));
    sx1=min(ROI(find(ROI(:,1)~=sx),1));
    ROI_d=sx1-sx;
    
    x_M = linspace(sx,ex,(ex-sx)/ROI_d+1); % x [m]
    y_M = linspace(sy,ey,(ey-sy)/ROI_d+1); % y [m]
    z_M = linspace(sz,ez,(ez-sz)/ROI_d+1); % z [m]
    x_scale=1;
    y_scale=1;
    z_scale=1;
    [X_M,Y_M,Z_M]=meshgrid(y_M,x_M,z_M);
    
    B=zeros(size(x_M,2),size(y_M,2),size(z_M,2));
    
    for i=1:size(ROI,1)
        xindex=floor((ROI(i,1)-sx)/(ROI_d*x_scale)+1);
        yindex=floor((ROI(i,2)-sy)/(ROI_d*y_scale)+1);
        zindex=floor((ROI(i,3)-sz)/(ROI_d*z_scale)+1);
        B(xindex,yindex,zindex)=ROI(i,4);
    end
    
    figure('name','x-y平面磁场分布');
    k=1;
    for i=floor(linspace(1,size(z_M,2),15))
        subplot(3,5,k);
        tempB=reshape(B(:,:,i),size(x_M,2),size(y_M,2));
        tempX=reshape(X_M(:,:,i),size(x_M,2),size(y_M,2));
        tempY=reshape(Y_M(:,:,i),size(x_M,2),size(y_M,2));
        if(size(x_M,2)>MAX_GRID)||(size(y_M,2)>MAX_GRID)
            scalex=MAX_GRID/size(x_M,2);
            scaley=MAX_GRID/size(y_M,2);
            if scalex>scaley
                scalex=scaley;
            end
            tempB=tempB(floor(linspace(1,size(x_M,2),floor(size(x_M,2)*scalex))),floor(linspace(1,size(y_M,2),floor(size(y_M,2)*scalex))));
            tempX=tempX(floor(linspace(1,size(x_M,2),floor(size(x_M,2)*scalex))),floor(linspace(1,size(y_M,2),floor(size(y_M,2)*scalex))));
            tempY=tempY(floor(linspace(1,size(x_M,2),floor(size(x_M,2)*scalex))),floor(linspace(1,size(y_M,2),floor(size(y_M,2)*scalex))));
        end
        
        %heatmap(tempB);
        contourf(tempX, tempY, tempB), colorbar
        axis equal;
        axis([X_M(1,1,i) X_M(1,end,i) Y_M(1,1,i) Y_M(end,1,i)]);
        title(['z=',num2str(z_M(i)),'处的磁场分布']);
        k=k+1;
        
    end
%     z0index=floor((0+ez)/ROI_d+1);
%     contourf(reshape(X_M(:,:,z0index),size(x_M,2),size(y_M,2)), reshape(Y_M(:,:,z0index),size(x_M,2),size(y_M,2)), reshape(B(:,:,z0index),size(x_M,2),size(y_M,2))), colorbar
    
    figure('name','分层磁场分布');
    zs=unique(ROI(:,3));
    fenceng=linspace(zs(floor(size(zs,1)/(3+2))),zs(size(zs,1)-floor(size(zs,1)/(3+2))),3);
    slice(X_M,Y_M,Z_M,B,[0],[],fenceng), colorbar
    
end