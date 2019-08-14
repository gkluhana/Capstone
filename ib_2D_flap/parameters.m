function param= parameters(Name, Value)
persistent param_
if isempty(param_)
    %Domain
    param_.L=1;
    param_.Lx = 116*param_.L;
    param_.Ly = 27*param_.L;
    %Grid
    param_.N=10;
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
    param_.Nb=ceil(pi*(param_.Lx/2)/(param_.h/2));
    param_.dtheta=2*pi/param_.Nb;
    param_.kp=[(2:param_.Nb),1];
    param_.km=[param_.Nb,(1:(param_.Nb-1))];
    param_.K=9000*10000;
    param_.rho=1;
    param_.mu=2;
    param_.c=param_.dtheta/(param_.h*param_.h);

    %Time
    param_.tmax=0.005;
    param_.dt=0.00001;
    param_.clockmax=ceil(param_.tmax/param_.dt);
    param_.snaptime= param_.tmax/(1000*param_.dt); %take 1000 snaps
    
    %Flappers
    param_.num_flappers =2;
    param_.width = 4*param_.L;
    
    %Prescribed motion variables for boundary
    param_.AoverC = 0.8;  %peak-to-peak amplitude ratio to chord
    param_.amprel = param_.AoverC*param_.width;
    param_.freq   = 4;
    param_.inPhase  = 0;
    param_.phi = 0;
    param_.ampfactor= 0.5;
    if param_.num_flappers == 1
        param_.inPhase = 1;
    end
    
    
    %Initial position of flappers
    param_.gappc = 0;
    param_.gap = param_.gappc*param_.width;
    param_.Tail2Head = param_.gap-param_.width;
    param_.leader_shift= 0;
    param_.xpos = 0:1:param_.num_flappers-1;
    param_.xcenter = param_.Lx/2 + param_.leader_shift - param_.gap*param_.xpos;
    param_.lateralShiftFac = 2;
    param_.ycenter = [param_.Ly/2  param_.Ly/2+param_.lateralShiftFac*param_.amprel];
    
    param_.Free = 1;
    param_.leaderFree = 1;
    param_.followerFree= 1;
    param_.followerConstant= 0;
    
   

param_.xgrid=(param_.h*(0:1:(param_.Nx-1)));
param_.ygrid=(param_.h*(0:1:(param_.Ny-1)));
[param_.xgrid,param_.ygrid] = ndgrid(param_.xgrid,param_.ygrid);

end
% if nargin > 0 
%   param_.(Name) = Value;
% end
param = param_;
end
