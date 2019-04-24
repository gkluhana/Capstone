frames = size(simData,1);
frametime = p.dt*p.snaptime;
for i = 1:frames
    X = simData{i,1};
    gap(i) = Tail2Head(p,X);
     if gap(i) < 0
        gap(i) = gap(i-1);
    end
end
time = frametime:frametime:p.tmax;
plot(time,gap);
xstr = strcat('Time (',num2str(p.freq),' flaps per second)');
xlabel(xstr);
ylabel('Gap between flappers');
front = fileName(p);
filename = strcat(front,'Gap.jpg');
saveas(gcf,filename);
