function f=vec_spread(param,F,X)
% spread F to grid
%global h N dtheta Nb;
Nx= param.Nx;
Ny= param.Ny;
h= param.h;
Nb=param.Nb;
num_flappers=param.num_flappers;

c=param.c;
wallc = param.wallc;
f=zeros(Nx,Ny,2);

s=X/h; % Get body position relative to grid
i=floor(s);
r=s-i;
w=vec_phi1(r(:,1)).*vec_phi2(r(:,2));%Evaluate delta function
w = permute(w, [1,3,2]); %Reogranize, this is quite fast


for k=1:size(X,1)
  if k>Nb*num_flappers
      c = wallc;
  end
  i1=mod((i(k,1)-1):(i(k,1)+2),Nx)+1; %Find affected cells
  i2=mod((i(k,2)-1):(i(k,2)+2),Ny)+1;
  
  %Spread force to fluid, this is the costly part (75% of the time for
  %N=100)
  ww = w(:,:,k);
  f(i1,i2,1)=f(i1,i2,1)+(c*F(k,1))*ww; 
  f(i1,i2,2)=f(i1,i2,2)+(c*F(k,2))*ww;
end

