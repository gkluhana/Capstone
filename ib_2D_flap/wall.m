function [X,T] = wall(p,X,T)

%Floor
wall_idx = size(X,1)+1:size(X,1)+p.Nb;
X(wall_idx,:) = zeros(p.Nb,2);
T(wall_idx,:) = zeros(p.Nb,2);

X(wall_idx,1) =[0:p.Lx/p.Nb:p.Lx-p.Lx/p.Nb];
T(wall_idx,1) =[0:p.Lx/p.Nb:p.Lx-p.Lx/p.Nb];

end
