function F=Force(p,X,T)
% global kp km dtheta K T;

%F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
follower = p.Nb+1:p.Nb+p.Nb;
D = -(1/p.Nb)*sum(T(follower) - X(follower))
F = -param.K*(X-(T+D));
