function w=laplacian(param,u)
% global ixm ixp iym iyp h;
w=(u(param.ixp,:,:)+u(param.ixm,:,:)+u(:,param.iyp,:)+u(:,param.iym,:)-4*u)/(param.h*param.h);

% im,ixm, iym = [N,1:(N-1)] = circular version of i-1
% ip, ixp , iym = [2:N,1]     = circular version of i+1
% N  = number of points in each space direction

