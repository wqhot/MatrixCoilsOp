%% Ŀ�곡����
% ROI��ROI����
% dir������ 0-x 1-y 2-z
% gradient���ݶȴ�С
%%
function target=createTargetROI(ROI,dir,gradient)
    target=[ROI,zeros(size(ROI,1),1)];
    target(:,4)=(target(:,dir+1)-0)*gradient;
end