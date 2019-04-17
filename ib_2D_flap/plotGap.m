frames = size(simData,1);
frametime = p.dt*p.snaptime;
for i = 1:frames
    X = simData{i,1};
    gap(i) = Tail2Head(p,X);
     if gap(i) < 0
        gap(i) = p.Lx - abs(gap(i));
    end
end
time = frametime:frametime:p.tmax;
plot(time,gap);
xstr = strcat('Time (',num2str(p.freq),' flaps per second)');
xlabel(xstr);
ylabel('Gap between flappers');
filename = strcat('Variable',num2str(p.tmax),'s',num2str(p.gap),'Gap.jpg');
saveas(gcf,filename);
