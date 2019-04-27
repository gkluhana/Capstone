
simData = cell(size(Xdata,1),5);
simData(:,1) = Xdata;
simData(:,2) = Tdata;
frames = size(simData,1);
frametime = p.dt*p.snaptime;
timeData = frametime:frametime:p.tmax;
for i=1:1
    simData{i,3} = timeData(i);
end
sim_idx = size(simData,1)
% XTperiodic