function u=init_fluid(param)

%%INITIALIZE FLUID
u=zeros(param.Nx,param.Ny,2);

%for j1=0:(Nx-1)
 % x=j1*h;
 % u(j1+1,:,2)=sin(2*pi*x/L);
%end


%%Don't calculate right now if no vorticity at the start
% 
% vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
% dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
% values= (-10*dvorticity):dvorticity:(10*dvorticity);
% valminmax=[min(values),max(values)];



% set(gcf,'double','on')
% contour(xgrid,ygrid,vorticity,values)
% hold on
%for i = 1:num_flappers
%    plot(X(:,1),X(:,2),'ko')
%    hold on
%    for i =1:num_flappers
%     plot(T((i-1)*Nb+1:i*Nb,1),T((i-1)*Nb+1:i*Nb,2),'r-')
%    end
%end
%axis([0,Lx,0,Ly])
%caxis(valminmax)
%axis equal
% axis manual
%drawnow
%hold off
