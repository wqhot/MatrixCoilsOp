function CoilsMatrix=closeCircleCoils(R,r)
    global defaultN;
    global defaultI;
    global defaultd;
    maxColNum=floor(R/r/sqrt(3));
    CoilsMatrix=[];
    rectangle('Position',[-R,-R,2*R,2*R],'Curvature',[1,1]);
    for i=1:maxColNum
        maxRowNum=floor(sqrt(R*R-(sqrt(3)*r*(i-1)+r)^2)/r);
        minY=-(floor(maxRowNum/2))*2*r+r*sqrt(3)/2*rem(i-1,2);
        for j=1:maxRowNum
            circleCenterX=(i-1)*r*sqrt(3)+r;
            circleCenterY=(j-1)*2*r+minY;
            rho=sqrt(circleCenterX^2+circleCenterY^2);
            theta=atan(circleCenterY/circleCenterX);
            if(rho<=R-r)
                rectangle('Position',[circleCenterX-r,circleCenterY-r,2*r,2*r],'Curvature',[1,1]);
                hold on;
                polar(theta,rho,'*');
                text(circleCenterX,circleCenterY,int2str(size(CoilsMatrix,1)+1));
                CoilsMatrix=[CoilsMatrix;rho,theta,circleCenterX,circleCenterY,r,sign(circleCenterX)*defaultN,defaultI,defaultd];
            end
        end
    end
    axis equal
    CoilsMatrixTemp=CoilsMatrix;
    CoilsMatrixTemp(:,2)=pi-CoilsMatrixTemp(:,2);
    CoilsMatrixTemp(:,3)=-CoilsMatrixTemp(:,3);
    CoilsMatrixTemp(:,6)=-CoilsMatrixTemp(:,6);
    CoilsMatrix=[CoilsMatrix;CoilsMatrixTemp];
    CoilsMatrix=sortrows(CoilsMatrix,3);
    CoilsMatrix(size(CoilsMatrix,1)/2+1:size(CoilsMatrix,1),:)=sortrows( CoilsMatrix(size(CoilsMatrix,1)/2+1:size(CoilsMatrix,1),:),-3);
    xs=unique(CoilsMatrix(:,3));
    for i=1:size(xs,1)
        ys=CoilsMatrix(find(CoilsMatrix(:,3)==xs(i)),:);
        ys=sortrows(ys,4);
        CoilsMatrix(find(CoilsMatrix(:,3)==xs(i)),:)=ys;
    end
    CoilsMatrix=[CoilsMatrix;CoilsMatrix];
    
end