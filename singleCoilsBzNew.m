
% z:Ŀ��λ������ڸ���Ȧˮƽ��ľ���
% x,y��Ŀ��λ������ڸ���Ȧ���ĵ�����
% c_r:����Ȧ�İ뾶
% I:����Ȧ��ͨ���ĵ���
% N:����Ȧ������
% d:�����ķ��� ��z�����Ϸ����¿���˳ʱ��Ϊ-1����ʱ��Ϊ1
% n:��⾫��

function B = singleCoilsBzNew(z,x,y,c_r,I,N,d,n)
 %18.4.2ʹ����Բ����
    u0=4*pi*10^(-7);
    syms theta
    f=(-y*c_r*sin(theta)-x*c_r*cos(theta)+c_r*c_r)/power(sqrt(power(z*z+(x-c_r*cos(theta)),2)+power(y-c_r*sin(theta),2)),3);
    
    B=u0*I*N*d/4/pi*double(int(f,theta,0,2*pi));
end   