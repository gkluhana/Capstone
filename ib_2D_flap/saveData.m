Xdata = simData(:,1);
Tdata = simData(:,2);
Fdata = simData(:,5);
filename = strcat('BothFree',num2str(p.tmax),'s',,num2str(p.gap),'dt',num2str(p.dt),'XTFp');
save(filename,'Xdata','Tdata','Fdata','p');
