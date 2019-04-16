%%Make Xdata and Tdata periodic in Xdirection for plotting
for i = 1:size(simData,1);
    temp = simData{i,1};
    temp(:,1) = mod(temp(:,1),p.Lx);
    simData{i,1} = temp;
    temp = simData{i,2};
    temp(:,1) = mod(temp(:,1),p.Lx);
    simData{i,2} = temp;
end
