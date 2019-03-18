function F=Force(param,X,T)
% global kp km dtheta K T;

%F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
F = -param.K*(X-T);