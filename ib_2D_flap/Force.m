function [F,T]=Force(p,X,T)
% global kp km dtheta K T;

%Matrix for adding Deviation to second flapper
follower = p.Nb+1:p.Nb+p.Nb;
E = zeros(size(X));
E(follower,1) = 1;
%F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
%Compute Deviation with zero horizontal force for follower

D = -(1/p.Nb)*sum(T(follower,1) - X(follower,1));
F = -p.K*(X-(T+D*E));
T = T+D*E;