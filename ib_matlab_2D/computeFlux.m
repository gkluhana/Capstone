%% Compute Flux
% parameters are stored as param.Nx,Ny,dt,tmax,
% simulation data in simData as [{vorticity}, {X} , {T} ,{time},{F},{u} ];
% simData{i,6} is u for ith snapshot of Data

% pick point to evaluate
xline = round(size(u,1)/4);

%get flux data
for i=1:sim_idx-1
u = simData{i,6};
flux(i) = sum(u(xline,:,1));
end

%Average over time for 100 snaps, assuming multiple of 100
for i = 1:numel(flux)/100
    Flux(i) = sum(flux((i-1)*100+1:(i)*100))/100;
end

%Plot 
plot(Flux)

end
%sum