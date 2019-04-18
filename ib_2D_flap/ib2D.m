% ib2D.m
% This script is the main program.

close all
clear
clc

%Initialize parameters
p = parameters()
p.a = init_a(p);            %matrix
[X,T] = flappers(p);        %[Boundary Points, Target Points]
u = init_fluid(p);          

%Check Initial Configuration of system
%plotConfig(p,X,T,u);

Trest = T(:,2);
sim_idx = 1;
simData = cell(ceil(p.clockmax/p.snaptime),5);
num_frames = 0;
for clock=1:p.clockmax
    time = clock*p.dt;
    XX=X+(p.dt/2)*interpB(p,u,X);
    [F,T] = Force(p,XX,T); 
    ff = spread(p,F,XX);
    T(:,2) =Trest -  (0.5*p.amprel*sin(2*pi*p.freq*time));
    [u,uu]=fluid(p,u,ff);
    X=X+p.dt*interpB(p,uu,XX);
    %!!Change Place for Calculation of T
    
%   FLUX
%     fluxeval = Nx/8;
%     flux = sum(u(fluxeval,:,1))*h; %times mesh width, integral over L
  
 if ~mod(clock,p.snaptime)
    simData(sim_idx,:) = [ {X} , {T} ,{time},{u} ,{F}];
       if ~mod(clock,p.snaptime*10)
          num_frames = num_frames + 10;
          fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end

end
