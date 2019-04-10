%Combining Flux,Force compute and f=plot code
figure;
hold off;
%Compute Flux
%flapper  = 'Fixed';
flapper  = 'Variable';
front = strcat(flapper,num2str(p.tmax),'s',num2str(p.gap));


% pick point to evaluate
xline = round(size(u,1)/4);
j=0;
%geti flux/force data
for dim = ['X','Y']
	j = j+1;
	for i=1:sim_idx-1
	u_sim = simData{i,4};
	flux(i) = sum(u_sim(xline,:,j));
	forceFlappers = simData{i,5};
	forceFollow(i) = sum(forceFlappers(p.Nb+1:p.Nb+p.Nb,j))*p.dtheta;
	end

	%Average over time for 100 snaps, assuming multiple of 100
	for i = 1:numel(flux)/100
	    Flux(i) = sum(flux((i-1)*100+1:(i)*100))/100;
	end

	%Plot Flux
	plot(flux,'o');
	xlabel('')
	ylabel('Net Flux averaged over time')
	  title(['Total Time: ' num2str(p.tmax,4) ', dt:' num2str(p.dt) ', h:' num2str(p.h), ', Nx-Ny:', num2str(p.Nx) '-' num2str(p.Ny) ', Nb:' num2str(p.Nb) ', Flappers:' num2str(p.num_flappers)])


	filename = strcat(front,'Flux',dim,'.jpg');

	saveas(gcf,filename);


	size(forceFlappers(p.Nb+1:p.Nb+p.Nb,1));
	snaps = sim_idx -1;
	interval = p.tmax / snaps;
	flap = 1 / p.freq;
	flapsnap = floor(flap / interval);
	totalflaps =floor(snaps/flapsnap);

	%Average over time for each flap, assuming multiple of 166
	for i = 1:totalflaps
	    ForceFollow(i) = sum(forceFollow((i-1)*flapsnap+1:(i)*flapsnap))/flapsnap;
	end

	%Plot raw force
	plot(forceFollow,'o');
	xlabel('snapshot number');
	ylabel('Net Force on Follower')
	  title(['Total Time: ' num2str(p.tmax,4) ', dt:' num2str(p.dt) ', h:' num2str(p.h), ', Nx-Ny:', num2str(p.Nx) '-' num2str(p.Ny) ', Nb-202'])

	filename = strcat(front,'force',dim,'.jpg');
	saveas(gcf,filename);

	%Plot averaged force
	plot(ForceFollow);
	xlabel('Flap Number')
	ylabel ('Time averaged Force on Folllower')
	filename=strcat(front,'Force',dim,'.jpg');
	saveas(gcf,filename);


end
