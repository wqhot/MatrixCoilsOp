
% z:目标位置相对于该线圈水平面的距离
% x,y：目标位置相对于该线圈中心的坐标
% c_r:该线圈的半径
% I:该线圈的通过的电流
% N:该线圈的匝数
% d:电流的方向 从z轴正上方向下看，顺时针为-1，逆时针为1
% n:求解精度

function B = singleCoilsBzNew(z,x,y,c_r,I,N,d,n)
 %18.4.2使用椭圆积分
    u0=4*pi*10^(-7);
    syms theta
    f=(-y*c_r*sin(theta)-x*c_r*cos(theta)+c_r*c_r)/power(sqrt(power(z*z+(x-c_r*cos(theta)),2)+power(y-c_r*sin(theta),2)),3);
    
    B=u0*I*N*d/4/pi*double(int(f,theta,0,2*pi));
end   