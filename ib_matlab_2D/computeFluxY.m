%% Compute Flux
% parameters are stored as param.Nx,Ny,dt,tmax,
% simulation data in simData as [{vorticity}, {X} , {T} ,{time},{F},{u} ];
% simData{i,6} is u for ith snapshot of Data

% pick point to evaluate
xline = round(size(u,1)/4);

%get flux data
for i=1:sim_idx-1
u_sim = simData{i,6};
flux(i) = sum(u_sim(xline,:,2));
end

%Average over time for 100 snaps, assuming multiple of 100
for i = 1:numel(flux)/100
    Flux(i) = sum(flux((i-1)*100+1:(i)*100))/100;
end

%Plot 
plot(flux,'o');
xlabel('')
ylabel('Net Flux averaged over time')
  title(['Total Time: ' num2str(param.tmax,4) ', dt:' num2str(param.dt) ', h:' num2str(param.h), ', Nx-Ny:', num2str(param.Nx) '-' num2str(param.Ny) ', Nb-202' ', Flappers:' num2str(param.num_flappers)])  

saveas(gcf,'Pictures/FluxY.jpg');

%sum
