function [X,T] = wall(p,X,T)

%Floor
wall_idx = size(X,1)+1:size(X,1)+p.wallNb;
X(wall_idx,:) = zeros(p.wallNb,2);
T(wall_idx,:) = zeros(p.wallNb,2);

X(wall_idx,1) =[0:p.Lx/p.wallNb:p.Lx-p.Lx/p.wallNb];
T(wall_idx,1) =[0:p.Lx/p.wallNb:p.Lx-p.Lx/p.wallNb];
end
