%%����ROI����
% R:ROI�뾶
% mode:ģʽ,aaΪ�̶����xyz����ģʽ��abΪ�̶����ͬ����ģʽ
%           baΪ�̶�����xyz����ģʽ��bbΪ�̶����ͬ����ģʽ
% d:��������
%%
function ROI=createROI(R,mode,d)
    mode='aa';
    ROI=[];
    if strcmp(mode,'aa')
        dxz=-R:d:R;
        [X,Y,Z]=meshgrid(dxz);
        l=X.*X+Y.*Y+Z.*Z;
        lsave=find(l<=R*R);
        ROI=[X(lsave),Y(lsave),Z(lsave)];
%         ROI=zeros(size(lsave,1),3);
%         for i=1:size(lsave,1)
%             nums=size(dxz,2);
%             z=floor(lsave(i))
%         end
    elseif strcmp(mode,'ab')
    elseif strcmp(mode,'ba')
        ROI=zeros(d,3);
        d1=floor(d/8);
        
    else
    end
end