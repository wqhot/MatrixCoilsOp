%function [BSmag,X,Y,Z,BX,BY,BZ] = BSmag_get_B(BSmag,X,Y,Z)
function [BSmag,BX,BY,BZ] = BSmag_get_B(BSmag,ROI)
%---------------------------------------------------
%  NAME:      BSmag_get_B.m
%  WHAT:      Calculates B at field points.
%  REQUIRED:  BSmag Toolbox 20150407
%  AUTHOR:    20150407, L. Queval (loic.queval@gmail.com)
%  COPYRIGHT: 2015, Loic Qu関al, BSD License (http://opensource.org/licenses/BSD-3-Clause).
%
%  USE:
%    [BSmag,X,Y,Z,BX,BY,BZ] = BSmag_get_B(BSmag,X,Y,Z)
%
%  INPUTS:
%    BSmag      = BSmag data structure
%    X          = Field points x-coordinate vector or matrix
%    Y          = Field points y-coordinate vector or matrix
%    Z          = Field points z-coordinate vector or matrix
%
%  OUTPUTS:
%    BSmag      = BSmag data structure (no update)
%    X          = Field points x-coordinate vector or matrix
%    Y          = Field points y-coordinate vector or matrix
%    Z          = Field points z-coordinate vector or matrix
%    BX         = Field points B x-component vector or matrix
%    BY         = Field points B y-component vector or matrix
%    BZ         = Field points B z-component vector or matrix
%----------------------------------------------------

mu0 = 4*pi*1e-7; % vacuum permeability [N/A^2]
           
BX = zeros(size(ROI,1),1);
BY = zeros(size(ROI,1),1);
BZ = zeros(size(ROI,1),1);

for nF = 1:BSmag.Nfilament % Loop on each filament

    Gamma = BSmag.filament(nF).Gamma;
    dGamma = BSmag.filament(nF).dGamma;
    I = BSmag.filament(nF).I;

    % Discretization of Gamma
    x_P = []; y_P = []; z_P = [];
    N = size(Gamma,1)-1; % Number of points defining Gamma
%     for i = 1:N % Loop on the segments defining gamma
%         L_Gamma_i = norm(Gamma(i,:)-Gamma(i+1,:));
%         NP = ceil(L_Gamma_i/dGamma); % Number of points required to have a discretization step smaller than dGamma
%         x_P = [x_P,linspace(Gamma(i,1), Gamma(i+1,1), NP)]; % discretization of Gamma for x component
%         y_P = [y_P,linspace(Gamma(i,2), Gamma(i+1,2), NP)]; % discretization of Gamma for y component
%         z_P = [z_P,linspace(Gamma(i,3), Gamma(i+1,3), NP)]; % discretization of Gamma for z component
%     end
    
    %Distances=zeros(size(ROI,1),N+1);
    
    Distances_x=repmat(ROI(:,1),1,N)-repmat((Gamma(1:end-1,1)'+Gamma(2:end,1)')/2,size(ROI,1),1);%每行代表DSV中的一个点，每列代表线圈的一小段
    Distances_y=repmat(ROI(:,2),1,N)-repmat((Gamma(1:end-1,2)'+Gamma(2:end,2)')/2,size(ROI,1),1);
    Distances_z=repmat(ROI(:,3),1,N)-repmat((Gamma(1:end-1,3)'+Gamma(2:end,3)')/2,size(ROI,1),1);
    Distances=sqrt(Distances_x.*Distances_x+Distances_y.*Distances_y+Distances_z.*Distances_z);
    Distances=Distances.*Distances.*Distances;%r^3
    %每段线圈的dl=(dl_x,dl_y,dl_z)
    dl_x=repmat(Gamma(2:end,1)'-Gamma(1:end-1,1)',size(ROI,1),1);%每行代表DSV中的一个点，每列代表线圈的一小段
    dl_y=repmat(Gamma(2:end,2)'-Gamma(1:end-1,2)',size(ROI,1),1);%每行代表DSV中的一个点，每列代表线圈的一小段
    dl_z=repmat(Gamma(2:end,3)'-Gamma(1:end-1,3)',size(ROI,1),1);%每行代表DSV中的一个点，每列代表线圈的一小段
    %每段线圈到场点的矢量r=(Distances_x,Distances_y,Distances_z)
    
    %每段线圈在场点产生的磁场dl×r/(r^3)
    BX_diff=(dl_y.*Distances_z-dl_z.*Distances_y)./Distances;
    BY_diff=(dl_z.*Distances_x-dl_x.*Distances_z)./Distances;
    BZ_diff=(dl_x.*Distances_y-dl_y.*Distances_x)./Distances;
    
    BX=BX+mu0*I/4/pi*sum(BX_diff,2);
    BY=BY+mu0*I/4/pi*sum(BY_diff,2);
    BZ=BZ+mu0*I/4/pi*sum(BZ_diff,2);
    
    % Add contribution of each source point P on each field point M (where we want to calculate the field)
%     for m = 1:size(X,1);
%         for n = 1:size(X,2);
%             for p = 1:size(X,3);
% 
%             % M is the field point
%             x_M = X(m,n,p);
%             y_M = Y(m,n,p);
%             z_M = Z(m,n,p);
% 
%             % Loop on each discretized segment of Gamma PkPk+1
%             for k = 1:length(x_P)-1
%                 PkM3 = (sqrt((x_M-x_P(k))^2 + (y_M-y_P(k))^2 + (z_M-z_P(k))^2))^3;
%                 DBx(k) = ((y_P(k+1)-y_P(k))*(z_M-z_P(k))-(z_P(k+1)-z_P(k))*(y_M-y_P(k)))/PkM3;
%                 DBy(k) = ((z_P(k+1)-z_P(k))*(x_M-x_P(k))-(x_P(k+1)-x_P(k))*(z_M-z_P(k)))/PkM3;
%                 DBz(k) = ((x_P(k+1)-x_P(k))*(y_M-y_P(k))-(y_P(k+1)-y_P(k))*(x_M-x_P(k)))/PkM3;
%             end
%             % Sum
%             BX(m,n,p) = BX(m,n,p) + mu0*I/4/pi*sum(DBx);
%             BY(m,n,p) = BY(m,n,p) + mu0*I/4/pi*sum(DBy);
%             BZ(m,n,p) = BZ(m,n,p) + mu0*I/4/pi*sum(DBz);
% 
%             end
%         end
%     end
  
end