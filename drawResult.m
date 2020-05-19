function drawResult(CoilsMatrix)
    figure('name','上级板');
    axis equal;
    for i=1:size(CoilsMatrix,1)/2
       title('上级板');
       r=CoilsMatrix(i,5);
       rectangle('Position',[CoilsMatrix(i,3)-r,CoilsMatrix(i,4)-r,2*r,2*r],'Curvature',[1,1]);
       hold on;
       text(CoilsMatrix(i,3),CoilsMatrix(i,4),[int2str(i),',',num2str(CoilsMatrix(i,6))]);     
    end
    hold off;
    
    figure('name','下级板');
    axis equal;
    for i=size(CoilsMatrix,1)/2+1:size(CoilsMatrix,1)
       title('下级板');
       r=CoilsMatrix(i,5);
       rectangle('Position',[CoilsMatrix(i,3)-r,CoilsMatrix(i,4)-r,2*r,2*r],'Curvature',[1,1]);
       hold on;
       text(CoilsMatrix(i,3),CoilsMatrix(i,4),[int2str(i),',',num2str(CoilsMatrix(i,6))]);     
    end
    hold off;
end