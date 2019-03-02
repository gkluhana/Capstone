% ib2D.m
% This script is the main program.
close all
clear all
clc

%T is location of target points
%delta, amprel, and freq are variables that prescrible the motion of the
%wing

global dt Nb N Nx Ny h rho mu ixp ixm iyp iym a delta amprel freq;
global kp km dtheta K T;
initialize
init_a
Trest = T(:,2);
snaptime = 50 ; %take snapshot after every snaptime 
for clock=1:clockmax
  XX=X+(dt/2)*interp(u,X);
  ff=spread(Force(XX),XX);
  T(:,2) =Trest - (delta/2 * ( amprel*sin(2*pi*freq*clock*dt)));
  [u,uu]=fluid(u,ff);
  X=X+dt*interp(uu,XX);
  %!!Change Place for Calculation of T

  
  %!!Caluclate flux across x = 0.1
  
  fprintf('Simulation Time is %d \n',clock*dt)
  
  %!!Change animation code to store data to file then plot simulation at the end
  if ~mod(clock,snaptime)
  vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
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


