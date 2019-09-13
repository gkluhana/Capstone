% ib2D.m for flappers
% This script is the main program.
close all
clear
clc

%Initialize parameters
p = parameters()
p.a = init_a(p);            %matrix
[X,T] = flappers(p);        %[X = Boundary Points,T = Target Points]
u = init_fluid(p);          

%Check Initial Configuration of system
% plotConfig(p,X,T,u);

%Flapper Rest Position
Trest = T(:,2);

% %Floor
[X,T] =  wall(p,X,T);                  %Floor
%Simulation Parameters
sim_idx = 1;
simData = cell(ceil(p.clockmax/p.snaptime),5);
num_frames = 0;

for clock=1:p.clockmax
    time = clock*p.dt;
    XX=X+(p.dt/2)*vec_interp(p,u,X);
    [F,T] = Force(p,XX,T); 
    ff = vec_spread(p,F,XX);
    
    %Update Target Points
    T(p.leader,2) = Trest(p.leader) -  (0.5*p.amprel*sin(2*pi*p.freq*time));
    T(p.follower,2) = Trest(p.follower) -  (p.ampfactor*0.5*p.amprel*sin(2*pi*p.freq*time - p.phi));
    
    
    [u,uu]=fluid(p,u,ff);
    X=X+p.dt*vec_interp(p,uu,XX);
 
 if ~mod(clock,p.snaptime)
    simData(sim_idx,:) = [ {X} , {T} ,{time},{u} ,{F}];
       if ~mod(clock,p.snaptime*10)
          num_frames = num_frames + 10;
           fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end

end
