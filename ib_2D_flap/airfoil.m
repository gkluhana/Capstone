function X = airfoil(L,xcenter,ycenter,w,Nb,dtheta)
% 
% global Nb
% global dtheta
% 

%Generate Unit Circle centered at origin
for k=0:(Nb-1)
  theta=k*dtheta;
  X(k+1,1)=cos(theta);
  X(k+1,2)=sin(theta);
end


%Transform the circle to Circle centered at (xshift,yshift) with radius R
xshift = 0.1;
yshift = 0;
R = 1 + xshift; %ensure passes through x= -1

X(:,1) = R* (X(:,1)) + xshift;
X(:,2) = R* (X(:,2)) + yshift;

%Jukowski Transform
Z =  X(:,1)+ i* X(:,2); 
z =  Z + 1./Z;
X(:,1) = real(z); 
X(:,2) = imag(z);

%Scale Airfoil to chord length 1 and center at origin
chord = max(X(:,1)) - min(X(:,1));
X(:,1) = X(:,1)/chord;
X(:,2) = X(:,2)/chord ;
shift = 0.5 - max(X(:,1));
X(:,1) =X(:,1) + shift ;


%Scale Airfoil to chord length w and move airfoil to desired position
X(:,1) = w*X(:,1) + xcenter; 
X(:,2) = w*X(:,2) + ycenter;

end