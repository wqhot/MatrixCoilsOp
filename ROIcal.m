%% ����ROI�����еĴŸ�Ӧǿ��
% x,y,z:Ŀ��λ������
% coilsMatrix:������Ȧ��������
% L:���¼������
% n:��⾫��
%%
function Bs=ROIcal(ROI,coilsMatrix,L,n)
    Bs=[ROI,zeros(size(ROI,1),1)];
    for i=1:size(ROI,1)
        Bs(i,4)=allCoilsBz(Bs(i,1),Bs(i,2),Bs(i,3),coilsMatrix,L,n);       
    end

end