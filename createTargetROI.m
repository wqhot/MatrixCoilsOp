%% 目标场建立
% ROI：ROI区域
% dir：方向 0-x 1-y 2-z
% gradient：梯度大小
%%
function target=createTargetROI(ROI,dir,gradient)
    target=[ROI,zeros(size(ROI,1),1)];
    target(:,4)=(target(:,dir+1)-0)*gradient;
end