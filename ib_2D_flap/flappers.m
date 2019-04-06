function [X,T] = flappers(param)

%% SPECIFY INITIAL CONFIGURATION OF ELASTIC BOUNDARY
    
    X = zeros(param.num_flappers*param.Nb,2);
    T = zeros(param.num_flappers*param.Nb,2);


%Jukowski Airfoils with Target Points with center (xcetner, ycenter) and chord length param.width
for i =1:param.num_flappers
    X((i-1)*param.Nb+1:i*param.Nb,:) = airfoil(param.L,param.xcenter(i),param.ycenter,param.width,param.Nb,param.dtheta);
    T((i-1)*param.Nb+1:i*param.Nb,:) = airfoil(param.L,param.xcenter(i),param.ycenter,param.width,param.Nb,param.dtheta);
end
