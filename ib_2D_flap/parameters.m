function param= parameters(Name, Value)
persistent param_
if isempty(param_)
    %Domain
    param_.L=1;
    param_.Lx = 116*param_.L;
    param_.Ly = 27*param_.L;
    
    %Grid Parameters
    param_.N=10;
    param_.h=param_.L/param_.N;
    param_.Nx = param_.Lx/param_.h;
    param_.Ny = param_.Ly/param_.h;
    param_.xgrid=(param_.h*(0:1:(param_.Nx-1)));
    param_.ygrid=(param_.h*(0:1:(param_.Ny-1)));
    [param_.xgrid,param_.ygrid] = ndgrid(param_.xgrid,param_.ygrid);

    % Indices for second difference formulas
    param_.ixp=[(2:param_.Nx),1];              %For symmetric domain  ip=[(2:N),1]
    param_.ixm=[param_.Nx,(1:(param_.Nx-1))];  %For symmetric domain  im=[N,(1:(N-1))]
    param_.iyp=[(2:param_.Ny),1];
    param_.iym=[param_.Ny,(1:(param_.Ny-1))];
    
    %Boundary
    param_.Nb=ceil(pi*(param_.Lx/2)/(param_.h/2));
    param_.dtheta=2*pi/param_.Nb;
    param_.kp=[(2:param_.Nb),1];
    param_.km=[param_.Nb,(1:(param_.Nb-1))];
    param_.K=9000*10000;
    param_.rho=1;
    param_.mu=2;
    param_.c=param_.dtheta/(param_.h*param_.h);

    %Time
    param_.tmax=20;
    param_.dt=0.00001;
    param_.clockmax=ceil(param_.tmax/param_.dt);
    param_.snaptime= param_.tmax/(1000*param_.dt); %take 1000 snaps
    
    %Flappers
    param_.num_flappers =2;
    param_.width = 4*param_.L;
    
    %Prescribed motion parameters for flappers
    param_.AoverC = 0.8;  %peak-to-peak amplitude ratio to chord
    param_.amprel = param_.AoverC*param_.width;
    param_.freq   = 4;          %Frequency
    param_.phi = 0;             %Phase
    param_.ampfactor= 0.5;      %A_follower/A_leader
    param_.floor = 1;
    
    
    %Initial position of flappers
    param_.gap = 10;
    param_.Tail2Head = param_.gap-param_.width;
    param_.leader_shift= 0;
    param_.xpos = 0:1:param_.num_flappers-1;
    param_.xcenter = param_.Lx/2 + param_.leader_shift - param_.gap*param_.xpos;
    param_.lateralShiftFac = 0;
    param_.ycenter = [param_.Ly/2  param_.Ly/2+param_.lateralShiftFac*param_.amprel];
    
    param_.Free = 1;
    param_.leaderFree = 1;
    param_.followerFree= 1;
    param_.followerConstant= 0;

    %Floor
    
end
% if nargin > 0 
%   param_.(Name) = Value;
% end
param = param_;
end
