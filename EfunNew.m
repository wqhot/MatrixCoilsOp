%% Ŀ�꺯������
% Bs���ų�
% target��Ŀ�꺯�����
%%
function Err=EfunNew(Bs,target)
    Err=sum(abs(Bs(:,4)-target(:,4)));
end