%%
% z:Ŀ��λ������ڸ���Ȧˮƽ��ľ���
% r:Ŀ��λ������ڸ���ȦԲ�ĵ�ˮƽ����
% c_r:����Ȧ�İ뾶
% I:����Ȧ��ͨ��ĵ���
% N:����Ȧ������
% d:�����ķ��� ��z�����Ϸ����¿���˳ʱ��Ϊ-1����ʱ��Ϊ1
% n:��⾫��
%%
function B = singleCoilsBz(z,r,c_r,I,N,d,n)
    u0=4*pi*10^(-7);
    k = (4*c_r*r/(z^2+(c_r+r)^2)); %18.4.2�޸ģ�ԭ��ʽ����
    %k = sqrt(4*c_r*r/(z^2+(c_r-r)^2));
    %NN = 1:1:n;
    
    %Temp=(fastFactorial(fastFactorial(2*NN-1)) ./ fastFactorial(fastFactorial(2*NN))).^2.*k.^(2*NN);
    %Temp2=(factorial(factorial(2*NN-1)) ./ factorial(factorial(2*NN))).^2.*k.^(2*NN);
    %K = pi/2 + pi/2 * sum(Temp);
    %E = pi/2 - pi/2 * sum(Temp ./ n);
    %E = pi/2 - pi/2 * sum(Temp ./ (2*NN-1));
    %B = d*N*u0*I/(2*pi*sqrt(z*z+(r+c_r)^2))*(K-(z^2-c_r^2+r^2)/(z^2+(c_r-r)^2)*E);
    [K,E]=ellipke(k);
    B = d*N*u0*I/(2*pi*sqrt((z*z+(r+c_r)^2))*r^2)*z*(-K+(z^2+c_r^2+r^2)/(z^2+(c_r-r)^2)*E);
end