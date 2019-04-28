
frames = size(simData,1);
frametime = p.dt*p.snaptime;
time = frametime:frametime:p.tmax;
flap = 1 / p.freq;
flapsnap = floor(flap / frametime)/2;
totalflaps =floor(frames/flapsnap);
velocity = zeros(frames,1);
%velocity
leader = 1:p.Nb;
if p.num_flappers > 1
follower = leader+p.Nb;
end
%flapper = leader;
%flapper = follower;
while true;

flapper = input('Plot leader or follower?');

T = simData{1,2};
leaderHeadbefore = max(T(flapper,1));
for i =2:frames
    crossing = max(T(flapper,1)) - min(T(flapper,1)) > 1.5*(p.width);
    T = simData{i,2};
    leaderHeadnow = max(T(flapper,1));
    if ~crossing;
        if leaderHeadnow - leaderHeadbefore > 1.5*(p.width)
        crossing = 1;
        end
    end
    if ~crossing
    velocity(i) = (leaderHeadnow - leaderHeadbefore) / frametime;
    leaderHeadbefore = leaderHeadnow;
%     plot(T(:,1),T(:,2))
%     xlim([0 p.Lx])
%     ylim([0 p.Ly])
%     drawnow
    else
        velocity(i) = velocity(i-1);
        leaderHeadbefore = leaderHeadnow;
    end
end
plot(time,velocity)
hold on
 xlim([0, 3])
xstr = strcat('Time (s) (',num2str(p.freq),' flaps per second)');
xlabel(xstr);
ylabel('Velocity of Flapper, \it U ','Interpreter','tex')
% for i = 1:totalflaps
%      velocityAvg((i-1)*flapsnap+1:(i)*flapsnap) = sum(velocity((i-1)*flapsnap+1:(i)*flapsnap))/flapsnap;
% end
again = input('Plot Again? 1/0')
if again
    multiple = 1
    continue
else
    break
end
end
if exist('multiple')
    legend('leader','follower')
else
end
front = fileName(p);
filename = strcat(front,'Velocity.jpg');
saveas(gcf,filename);
hold off;

% hold on 
% plot(velocityAvg)
% ylim([-10, 10])
