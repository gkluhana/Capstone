    % convert the image to a frame
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

Trest = T(:,2);
snaptime = 100; %take snapshot after every snaptime 
sim_idx = 1;
simData = cell(ceil(clockmax/snaptime),6);
num_frames = 0;
for clock=1:clockmax
    time = clock*dt;
    XX=X+(dt/2)*interp(u,X);
    F = Force(XX); 
    ff = spread(F,XX);
    T(:,2) =Trest - (delta/2 * ( amprel*sin(2*pi*freq*time)));
    [u,uu]=fluid(u,ff);
    X=X+dt*interp(uu,XX);
    %!!Change Place for Calculation of T
    
%   FLUX
%     fluxeval = Nx/8;
%     flux = sum(u(fluxeval,:,1))*h; %times mesh width, integral over L
  
 if ~mod(clock,snaptime)
  vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
  simData(sim_idx,:) = [{vorticity}, {X} , {T} ,{time},{F},{u} ];
       if ~mod(clock,snaptime*10)
          num_frames = num_frames + 10;
          fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end

end
