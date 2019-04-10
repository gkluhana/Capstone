Xdata = simData(:,1);
Tdata = simData(:,2);
Fdata = simData(:,5);
filename = strcat('Variable',num2str(p.tmax),'s',num2str(p.gap),'XTFp');
save(filename,'Xdata','Tdata','Fdata','p');
