%%
% x,y,z:Ŀ��λ�����
% coilsMatrix:������Ȧ�������
% L:���¼������
% n:��⾫��
%%
function B = allCoilsBz(x,y,z,coilsMatrix,L,n)
    B=0;
    for i=1:size(coilsMatrix)/2
        %�������λ��
        z1=L/2-z;
        %z2=z-L/2; %18.4.2��
        z2=z+L/2;
        dx=x-coilsMatrix(i,3);
        dy=y-coilsMatrix(i,4);
        r=sqrt(dx*dx+dy*dy);
%         B=B+singleCoilsBzNew(z1,dx,dy,coilsMatrix(i,5),coilsMatrix(i,7),coilsMatrix(i,6),coilsMatrix(i,8),n);
%         B=B+singleCoilsBzNew(z2,dx,dy,coilsMatrix(i+size(coilsMatrix,1)/2,5),coilsMatrix(i+size(coilsMatrix,1)/2,7),coilsMatrix(i+size(coilsMatrix,1)/2,6),coilsMatrix(i+size(coilsMatrix,1)/2,8),n);
        B=B+singleCoilsBz(z1,r,coilsMatrix(i,5),coilsMatrix(i,7),coilsMatrix(i,6),coilsMatrix(i,8),n);
        B=B+singleCoilsBz(z2,r,coilsMatrix(i+size(coilsMatrix,1)/2,5),coilsMatrix(i+size(coilsMatrix,1)/2,7),coilsMatrix(i+size(coilsMatrix,1)/2,6),coilsMatrix(i+size(coilsMatrix,1)/2,8),n);
    end
end