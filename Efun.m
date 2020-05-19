%% Ŀ�꺯������
% Bs���ų�
% tar��Ŀ�꺯�����
%%
function tar=Efun(Bs)
    %z������
    Bsz=sortrows(Bs,3);
    %ÿһ��ľ�����
    Zs=unique(Bsz(:,3));
    Z_ave=zeros(size(Zs));
    sum1=0;
    for i=1:size(Zs,1)
        Bsz_temp=Bsz(find(Bsz(:,3)==Zs(i)),4);
        Z_ave(i)=mean(Bsz_temp);
        sum1=sum1+std(Bsz_temp);
    end
    %�ݶȾ�����
    deltaBsz=zeros(size(Zs,1)-1,1);
    for i=1:size(deltaBsz,1)
        deltaBsz(i)=Z_ave(i+1)-Z_ave(i);
    end
    sum2=std(deltaBsz);
    %�ݶ�ǿ��
    maxBz=max(Z_ave);
    minBz=min(Z_ave);
    if minBz==maxBz
        sum3=Inf;
    else
        sum3=abs(Zs(1)-Zs(end))/(maxBz-minBz);
    end
    %��Ȩ
    tar=2*sum1+2*sum2+sum3/10;
end