% ib2D.m
% This script is the main program.
close all
clear all
clc

%T is location of target points
%delta, amprel, and freq are variables that prescrible the motion of the
%wing

global dt Nb N  h rho mu  a;
global Nx Ny ixp ixm iyp iym delta amprel freq num_flappers;
global kp km dtheta K T;
initialize
init_a
Trest = T(:,2,:);
snaptime = 50 ; %take snapshot after every snaptime 
firstsnap =1;
ff = zeros(Nx,Ny)
for clock=1:clockmax
  for i = 1 : num_flappers
    XX(:,:,i)=X(:,:,i)+(dt/2)*interp(u,X(:,:,i));
    ff = spread(Force(XX(:,:,i)),XX(:,:,i));
  end
  
  T(:,2,:) =Trest - (delta/2 * ( amprel*sin(2*pi*freq*clock*dt)));
  [u,uu]=fluid(u,ff);
  
  for i = 1:num_flappers
     X(:,:,i)=X(:,:,i)+dt*interp(uu,XX(:,:,i));
  end
  
  %!!Change Place for Calculation of T

  
  %!!Caluclate flux across x = 0.1
  
  fprintf('Simulation Time is %d \n',clock*dt)
  
  %!!Change animation code to store data to file then plot simulation at the end
  if ~mod(clock,snaptime)
  vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
%   if firstsnap
  dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
  values= (-10*dvorticity):dvorticity:(10*dvorticity);
  valminmax=[min(values),max(values)];
%   firstsnap = 0;
%   end
  contour(xgrid,ygrid,vorticity,values)
  hold on
  plot(X(:,1),X(:,2),'ko')
  plot(T(:,1),T(:,2),'r-')
  axis([0,Lx,0,Ly])
  caxis(valminmax)
  axis equal
  axis manual
  drawnow
  hold off
  end
end


