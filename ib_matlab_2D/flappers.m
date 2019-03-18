function [X,T] = flappers(param,num)

%% SPECIFY INITIAL CONFIGURATION OF ELASTIC BOUNDARY
    param.num_flappers= num;
    X = zeros(param.num_flappers*param.Nb,2);
    T = zeros(param.num_flappers*param.Nb,2);


%Jukowski Airfoils with Target Points with center (xcetner, ycenter) and chord length w
    param.w = param.L/2;
    param.gap = param.Lx/4;
    param.leader_shift = param.Lx/4;
    param.xpos = 0:1:param.num_flappers-1;
    param.xcenter = param.Lx/2 + param.leader_shift - param.gap*param.xpos;
    param.ycenter = param.Ly/2;
for i =1:param.num_flappers
    X((i-1)*param.Nb+1:i*param.Nb,:) = airfoil(param.L,param.xcenter(i),param.ycenter,param.w,param.Nb,param.dtheta);
    T((i-1)*param.Nb+1:i*param.Nb,:) = airfoil(param.L,param.xcenter(i),param.ycenter,param.w,param.Nb,param.dtheta);
end