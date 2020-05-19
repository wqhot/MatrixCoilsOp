%% 计算ROI区域中的磁感应强度
% x,y,z:目标位置坐标
% coilsMatrix:矩阵线圈参数矩阵
% L:上下极板距离
% n:求解精度
%%
function Bs=ROIcal(ROI,coilsMatrix,L,n)
    Bs=[ROI,zeros(size(ROI,1),1)];
    for i=1:size(ROI,1)
        Bs(i,4)=allCoilsBz(Bs(i,1),Bs(i,2),Bs(i,3),coilsMatrix,L,n);       
    end

end