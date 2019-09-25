function [F,T]=Force(p,X,T)

%Matrix for adding Deviation to flappers
if p.Free
	E = zeros(size(X,1),size(X,2),p.num_flappers);
    
        E(p.leader,  1,1)  = 1;
        E(p.follower,1,2)  = 1;
end

%Compute Deviation with zero horizontal force for flappers
if p.leaderFree %Leader finds its own position
	D(1)  = -(1/p.Nb)*sum(T(p.leader,  1) - X(p.leader,  1)); 
	T = T+D(1)*E(:,:,1);
end

if p.followerFree %Follower finds its own position
	D(2)  = -(1/p.Nb)*sum(T(p.follower,1) - X(p.follower,1));
	T = T+D(2)*E(:,:,2);
end

if p.followerConstant %Follower deviates the same as leader
 	T = T+D(1)*E(:,:,2);
end
%Compute Force
F = -p.K*(X-T);

