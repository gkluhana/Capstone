function param= parameters(Name, Value)
persistent param_
if isempty(param_)
    %Domain
    param_.L=1.0;
    param_.Lx = 3.0*param_.L;
    param_.Ly = param_.L;
    %Grid
    param_.N=128;
    param_.h=param_.L/param_.N;
    param_.Nx = param_.Lx/param_.h;
    param_.Ny = param_.Ly/param_.h;

    % Indices for second difference formulas
    %For symmetric domain
    % ip=[(2:N),1]
    % im=[N,(1:(N-1))]
    
    param_.ixp=[(2:param_.Nx),1];
    param_.ixm=[param_.Nx,(1:(param_.Nx-1))];
    param_.iyp=[(2:param_.Ny),1];
    param_.iym=[param_.Ny,(1:(param_.Ny-1))];
    
    %Boundary
    param_.Nb=ceil(pi*(param_.L/2)/(param_.h/2));
    param_.dtheta=2*pi/param_.Nb;
    param_.kp=[(2:param_.Nb),1];
    param_.km=[param_.Nb,(1:(param_.Nb-1))];
    param_.K=3000;
    param_.rho=1;
    param_.mu=0.01;
    param_.c=param_.dtheta/(param_.h*param_.h);

    %Time
    param_.tmax=0.010;
    param_.dt=0.00001;
    param_.clockmax=ceil(param_.tmax/param_.dt);
    
    %Flappers
    param_.num_flappers = 2;
    param_.width = param_.L/2;
    param_.gappc = 0.1;
    param_.gap = param_.Lx/4 + param_.gappc*param_.L;
    param_.leader_shift= param_.Lx/4;
    param_.xpos = 0:1:param_.num_flappers-1;
    param_.xcenter = param_.Lx/2 + param_.leader_shift - param_.gap*param_.xpos;
    param_.ycenter = param_.Ly/2;
     
    %Prescribed motion variables for boundary
    param_.delta  = param_.L/2;
    param_.amprel = 3*param_.L/4;
    param_.freq   = 3;
   

param_.xgrid=(param_.h*(0:1:(param_.Nx-1)));
param_.ygrid=(param_.h*(0:1:(param_.Ny-1)));
[param_.xgrid,param_.ygrid] = ndgrid(param_.xgrid,param_.ygrid);

end
% if nargin > 0 
%   param_.(Name) = Value;
% end
param = param_;
end
