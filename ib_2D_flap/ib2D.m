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
% plotConfig(p,X,T,u);

Trest = T(:,2);
sim_idx = 1;
simData = cell(ceil(p.clockmax/p.snaptime),5);
num_frames = 0;
leader = 1:p.Nb;
if p.num_flappers >1
    follower = p.Nb+1 : size(X,1);
end
    
for clock=1:p.clockmax
    time = clock*p.dt;
    XX=X+(p.dt/2)*interpB(p,u,X);
    [F,T] = Force(p,XX,T); 
    ff = spread(p,F,XX);
    %Update Target Points
    if p.inPhase
        T(:,2) =Trest -  (0.5*p.amprel*sin(2*pi*p.freq*time));
    else
        T(leader,2) = Trest(leader) -  (0.5*p.amprel*sin(2*pi*p.freq*time));
        T(follower,2) = Trest(follower) -  (p.ampfactor*0.5*p.amprel*sin(2*pi*p.freq*time - p.phi));
    end
    [u,uu]=fluid(p,u,ff);
    X=X+p.dt*interpB(p,uu,XX);
 
 if ~mod(clock,p.snaptime)
    simData(sim_idx,:) = [ {X} , {T} ,{time},{u} ,{F}];
       if ~mod(clock,p.snaptime*10)
          num_frames = num_frames + 10;
           fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end

end
