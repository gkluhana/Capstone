function plotConfig(param,X,T,u);
p = param;
%plot Boundary Points
 plot(X(:,1),X(:,2),'kx')
 hold on
%plot Target Points
for j =1:p.num_flappers
     plot(T((j-1)*p.Nb+1:j*p.Nb,1),T((j-1)*p.Nb+1:j*p.Nb,2),'r-')
end
%plot vorticity if not zero

%dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
%values= (-10*dvorticity):dvorticity:(10*dvorticity);
%valminmax=[min(values),max(values)];
%contour(p.xgrid,p.ygrid,vorticity,values);

%Format Plot
xlim([0 p.Lx])
ylim([0 p.Ly])
%Text to Chart
Grid = [' h:' num2str(p.h), ', Nx-Ny:', num2str(p.Nx) '-' num2str(p.Ny)];
text(0,0.99*p.Ly,Grid);
Time = [' dt:' num2str(p.dt)];
text(0,0.97*p.Ly,Time);
Flappers = [' Flappers:' num2str(p.num_flappers) ', Gap:' num2str(p.Tail2Head) ', Nb:' num2str(p.Nb)];
text(0,0.95*p.Ly,Flappers);

front = fileName(p);
filename = strcat(front,'InitConfig.jpg');
saveas(gcf,filename);

