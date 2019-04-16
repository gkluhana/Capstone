function [F,T]=Force(p,X,T)
% global kp km dtheta K T;

%Matrix for adding Deviation to flappers
Free = 1;
leaderFree = 1;
followerFree=1;

if Free
	leader   = 1:p.Nb;
	follower = leader + p.Nb;
	E = zeros(size(X,1),size(X,2),p.num_flappers);
	E(leader,  1,1)  = 1;
	E(follower,1,2)  = 1;
end

%F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);

%Compute Deviation with zero horizontal force for flappers
if leaderFree
	D(1)  = -(1/p.Nb)*sum(T(leader,  1) - X(leader,  1)); 
	T = T+D(1)*E(:,:,1);
end

if followerFree 
	D(2)  = -(1/p.Nb)*sum(T(follower,1) - X(follower,1));
	T = T+D(2)*E(:,:,2);
end


%Compute Force
F = -p.K*(X-T);

