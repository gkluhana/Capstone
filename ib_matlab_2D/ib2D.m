% convert the image to a frame
% ib2D.m
% This script is the main program.

close all
clear
clc

%T is location of target points
%delta, amprel, and freq are variables that prescrible the motion of the
%wing


param = parameters();
% initialize
param.a = init_a(param);
[X,T] = flappers(param,param.num_flappers);
u = init_fluid(param);

Trest = T(:,2);
snaptime = 100; %take snapshot after every snaptime 
sim_idx = 1;
simData = cell(ceil(param.clockmax/snaptime),6);
num_frames = 0;
for clock=1:param.clockmax
    time = clock*param.dt;
    XX=X+(param.dt/2)*interpB(param,u,X);
    F = Force(param,XX,T); 
    ff = spread(param,F,XX);
    T(:,2) =Trest - (param.delta/2 * ( param.amprel*sin(2*pi*param.freq*time)));
    [u,uu]=fluid(param,u,ff);
    X=X+param.dt*interpB(param,uu,XX);
    %!!Change Place for Calculation of T
    
%   FLUX
%     fluxeval = Nx/8;
%     flux = sum(u(fluxeval,:,1))*h; %times mesh width, integral over L
  
 if ~mod(clock,snaptime)
  vorticity=(u(param.ixp,:,2)-u(param.ixm,:,2)-u(:,param.iyp,1)+u(:,param.iym,1))/(2*param.h);
  simData(sim_idx,:) = [{vorticity}, {X} , {T} ,{time},{F},{u} ];
       if ~mod(clock,snaptime*10)
          num_frames = num_frames + 10;
          fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end

end
