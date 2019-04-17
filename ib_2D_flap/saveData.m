Xdata = simData(:,1);
Tdata = simData(:,2);
Fdata = simData(:,5);
filename = strcat('BothFree',num2str(p.tmax),'s','dt',num2str(p.dt),num2str(p.gap),'XTFp');
save(filename,'Xdata','Tdata','Fdata','p');
