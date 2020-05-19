%% 目标函数计算
% Bs：磁场
% target：目标函数结果
%%
function Err=EfunNew(Bs,target)
    Err=sum(abs(Bs(:,4)-target(:,4)));
end