%Compute Force
% parameters are stored as param.Nx,Ny,dt,tmax,
% simulation data in simData as [{vorticity}, {X} , {T} ,{time},{F},{u} ];
% simData{i,6} is u for ith snapshot of Data

% pick point to evaluate
xline = round(size(u,1)/4);

%get flux data
for i=1:sim_idx-1
forceFlappers = simData{i,5};
forceFollow(i) = sum(forceFlappers(param.Nb+1:param.Nb+param.Nb,1))*param.dtheta;
end
size(forceFlappers(param.Nb+1:param.Nb+param.Nb,1))
snaps = sim_idx -1
interval = param.tmax / snaps
flap = 1 / param.freq
flapsnap = floor(flap / interval)
totalflaps =floor(snaps/flapsnap)
 
%Average over time for each flap, assuming multiple of 166
for i = 1:totalflaps
    ForceFollow(i) = sum(forceFollow((i-1)*flapsnap+1:(i)*flapsnap))/flapsnap;
end

%Plot raw force
plot(forceFollow,'o');
xlabel('snapshot number');
ylabel('Net Force on Follower')
  title(['Total Time: ' num2str(param.tmax,4) ', dt:' num2str(param.dt) ', h:' num2str(param.h), ', Nx-Ny:', num2str(param.Nx) '-' num2str(param.Ny) ', Nb-202'])  
saveas(gcf,'forceX.jpg');

%Plot averaged force
plot(ForceFollow);
xlabel('Flap Number')
ylabel ('Time averaged Force on Folllower')
saveas(gcf,'{Pictures/ForceX.jpg');
