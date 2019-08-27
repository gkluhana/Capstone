function [F,T]=Force(p,X,T)
% global kp km dtheta K T;

%Matrix for adding Deviation to flappers
Free = p.Free;
leaderFree = p.leaderFree;
followerFree=p.followerFree;
followerConstant=p.followerConstant; 
%Treats all followers as same

if Free
	leader   = 1:p.Nb;
	follower = p.Nb+1:p.Nb*(p.num_flappers) ;
	E = zeros(size(X,1),size(X,2),p.num_flappers);
    
	if leaderFree
        E(leader,  1,1)  = 1;
	end
    if followerFree|followerConstant	
        E(follower,1,2)  = 1;
	end
end
%Check for a wall

%F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);

%Compute Deviation with zero horizontal force for flappers
if leaderFree %Leader finds its own position
	D(1)  = -(1/p.Nb)*sum(T(leader,  1) - X(leader,  1)); 
	T = T+D(1)*E(:,:,1);
end

if followerFree %Follower finds its own position
	D(2)  = -(1/p.Nb)*sum(T(follower,1) - X(follower,1));
	T = T+D(2)*E(:,:,2);
end

if followerConstant %Follower deviates the same as leader
 	T = T+D(1)*E(:,:,2);
end

%Compute Force
F = -p.K*(X-T);

