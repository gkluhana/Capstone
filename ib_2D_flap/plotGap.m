snaptime = 200;
p.snaptime = snaptime;
frames = size(Xdata,1);
frametime = p.dt*p.snaptime;
simData = cell(frames,5);
simData(:,1) = Xdata;
simData(:,2) = Tdata;
simData(:,5) = Fdata;
simData(:,3) = {frametime:frametime:p.tmax};  %time
for i = 1:frames
    X = simData{i,1};
    gap(i) = Tail2Head(p,X);
end
time = simData{:,3};
plot(time,gap);
xstr = strcat('Time (',num2str(p.freq),' flaps per second)');
xlabel(xstr);
ylabel('Gap between flappers');
filename = strcat('Variable',num2str(p.tmax),'s',num2str(p.gap),'Gap.jpg');
saveas(gcf,filename);
