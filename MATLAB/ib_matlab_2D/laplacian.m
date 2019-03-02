function w=laplacian(u)
global ixm ixp iym iyp h;
w=(u(ixp,:,:)+u(ixm,:,:)+u(:,iyp,:)+u(:,iym,:)-4*u)/(h*h);

% im,ixm, iym = [N,1:(N-1)] = circular version of i-1
% ip, ixp , iym = [2:N,1]     = circular version of i+1
% N  = number of points in each space direction

