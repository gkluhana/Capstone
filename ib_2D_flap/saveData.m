Xdata = simData(:,1);
Tdata = simData(:,2);
Fdata = simData(:,5);
front = fileName(p);
filename = strcat(front,'XTFp.mat');
save(filename,'Xdata','Tdata','Fdata','p');
