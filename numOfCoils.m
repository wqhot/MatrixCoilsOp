function CoilsMatrix=numOfCoils(R,r)
    global defaultN;
    global defaultI;
    global defaultd;
    n=floor(R/2/r);
    Length=zeros(n);
    for i=1:n
        for j=1:n
            Length(i,j)=((i-1)*2*r+r)^2+((j-1)*2*r+r)^2;

        end
    end
    CoilsMatrix=[];
    result=4*length(find(Length<=(R-r)^2));
    %CoilsMatrix=zeros(results,3);
    %��ͼ
    figure('name','��Ȧ�ֲ�');
    rectangle('Position',[-R,-R,2*R,2*R],'Curvature',[1,1]);
    axis equal;
    hold on;
    circleNum=1;
    for i=1:n
        for j=1:n
            if  Length(i,j)<=(R-r)^2
                rho=sqrt(((i-1)*2*r+r)^2+((j-1)*2*r+r)^2);
                theta=pi/2-atan(((i-1)*2*r+r)/((j-1)*2*r+r));
                rectangle('Position',[((i-1)*2*r+r)-r,((j-1)*2*r+r)-r,2*r,2*r],'Curvature',[1,1]);
                text(((i-1)*2*r+r),((j-1)*2*r+r),int2str(circleNum),'FontName','Times New Roman','FontSize',16);
                circleNum=circleNum+1;
                CoilsMatrix=[CoilsMatrix;rho,theta,((i-1)*2*r+r),((j-1)*2*r+r),r,sign(((i-1)*2*r+r))*defaultN,defaultI,defaultd];
                rectangle('Position',[-((i-1)*2*r+r)-r,((j-1)*2*r+r)-r,2*r,2*r],'Curvature',[1,1]);
                text(-((i-1)*2*r+r),((j-1)*2*r+r),int2str(circleNum),'FontName','Times New Roman','FontSize',16);
                circleNum=circleNum+1;
                CoilsMatrix=[CoilsMatrix;rho,theta+pi/2,-((i-1)*2*r+r),((j-1)*2*r+r),r,sign(-((i-1)*2*r+r))*defaultN,defaultI,defaultd];
                rectangle('Position',[-((i-1)*2*r+r)-r,-((j-1)*2*r+r)-r,2*r,2*r],'Curvature',[1,1]);
                text(-((i-1)*2*r+r),-((j-1)*2*r+r),int2str(circleNum),'FontName','Times New Roman','FontSize',16);
                circleNum=circleNum+1;
                CoilsMatrix=[CoilsMatrix;rho,theta+pi,-((i-1)*2*r+r),-((j-1)*2*r+r),r,sign(-((i-1)*2*r+r))*defaultN,defaultI,defaultd];
                rectangle('Position',[((i-1)*2*r+r)-r,-((j-1)*2*r+r)-r,2*r,2*r],'Curvature',[1,1]);
                text(((i-1)*2*r+r),-((j-1)*2*r+r),int2str(circleNum),'FontName','Times New Roman','FontSize',16);
                circleNum=circleNum+1;
                CoilsMatrix=[CoilsMatrix;rho,theta+3*pi/2,((i-1)*2*r+r),-((j-1)*2*r+r),r,sign(((i-1)*2*r+r))*defaultN,defaultI,defaultd];
            end           
        end
    end
    %��ʼ���򣬰�x,y����
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