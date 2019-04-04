% convert the image to a frame
% ib2D.m
% This script is the main program.

close all
clear
clc

%T is location of target points
%delta, amprel, and freq are variables that prescrible the motion of the
%wing


p = parameters();
% initialize
p.a = init_a(p);
[X,T] = flappers(p);
u = init_fluid(p);

plotConfig(p,X,T,u);



Trest = T(:,2);
snaptime = 200; %take snapshot after every snaptime 
sim_idx = 1;
simData = cell(ceil(p.clockmax/snaptime),6);
num_frames = 0;
for clock=1:p.clockmax
    time = clock*p.dt;
    XX=X+(p.dt/2)*interpB(p,u,X);
    F = Force(p,XX,T); 
    ff = spread(p,F,XX);
    T(:,2) =Trest - (p.delta/2 * ( p.amprel*sin(2*pi*p.freq*time)));
    [u,uu]=fluid(p,u,ff);
    X=X+p.dt*interpB(p,uu,XX);
    %!!Change Place for Calculation of T
    
%   FLUX
%     fluxeval = Nx/8;
%     flux = sum(u(fluxeval,:,1))*h; %times mesh width, integral over L
  
 if ~mod(clock,snaptime)
  vorticity=(u(p.ixp,:,2)-u(p.ixm,:,2)-u(:,p.iyp,1)+u(:,p.iym,1))/(2*p.h);
  simData(sim_idx,:) = [{vorticity}, {X} , {T} ,{time},{F},{u} ];
       if ~mod(clock,snaptime*10)
          num_frames = num_frames + 10;
          fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end

end
