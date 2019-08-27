%initialize.m
%% VARIABLES
L=1.0
Lx = 3.0*L
Ly = L

N=128

h=L/N

Nx = Lx/h
Ny = Ly/h
% ip=[(2:N),1]
% im=[N,(1:(N-1))]

ixp=[(2:Nx),1]
ixm=[Nx,(1:(Nx-1))]

iyp=[(2:Ny),1]
iym=[Ny,(1:(Ny-1))]
Nb=ceil(pi*(L/2)/(h/2))
dtheta=2*pi/Nb
kp=[(2:Nb),1]
km=[Nb,(1:(Nb-1))]
K=9000
rho=1
mu=0.01
tmax=0.00050
dt=0.00001
clockmax=ceil(tmax/dt)

%Prescribed motion variables
delta  = L/2
amprel = 3*L/4
freq   = 3
%% SPECIFY INITIAL CONFIGURATION OF ELASTIC BOUNDARY
num_flappers= 2
X = zeros(num_flappers*Nb,2);
T = zeros(num_flappers*Nb,2);
W = zeros(Nb,2); 

%Jukowski Airfoils with Target Points with center (xcetner, ycenter) and chord length w
w = L/2;
gap = Lx/4
leader_shift = Lx/4
xpos = 0:1:num_flappers-1
xcenter = Lx/2 + leader_shift - gap*xpos
ycenter = Ly/2;
for i =1:num_flappers
    X((i-1)*Nb+1:i*Nb,:) = airfoil(L,xcenter(i),ycenter,w);
    T((i-1)*Nb+1:i*Nb,:) = airfoil(L,xcenter(i),ycenter,w);
end

%Circle with Center (c(1),c(2)) and and Radius r
% c(1) = L/2
% c(2) = L/2
% r = L/4
% 
% for k=0:(Nb-1)
%   theta=k*dtheta;
%   X(k+1,1)=c(1)+r*cos(theta);
%   X(k+1,2)=c(2)+ r*sin(theta);
% end

%%INITIALIZE FLUID

u=zeros(Nx,Ny,2);

%for j1=0:(Nx-1)
 % x=j1*h;
 % u(j1+1,:,2)=sin(2*pi*x/L);
%end

%%Don't calculate right now if no vorticity at the start

vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
values= (-10*dvorticity):dvorticity:(10*dvorticity);
valminmax=[min(values),max(values)];

xgrid=(h*(0:1:(Nx-1)))';
xgrid= repmat(xgrid,1,Ny);
ygrid=(h*(0:1:(Ny-1)));
ygrid= repmat(ygrid,Nx,1);


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

