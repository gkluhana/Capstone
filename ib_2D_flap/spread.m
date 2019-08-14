function f=spread(param,F,X)

Nx= param.Nx;
Ny= param.Ny;
h= param.h;
Nb=param.Nb;
num_flappers=param.num_flappers;

c=param.c;
f=zeros(Nx,Ny,2);

for k=1:Nb*num_flappers
  s=X(k,:)/h;
  i=floor(s);
  r=s-i;
  i1=mod((i(1)-1):(i(1)+2),Nx)+1;
  i2=mod((i(2)-1):(i(2)+2),Ny)+1;
  
    %phi1
    
    q1=sqrt(1+4*r(1)*(1-r(1)));
    w1(4,:)=(1+2*r(1)-q1)/8;
    w1(3,:)=(1+2*r(1)+q1)/8;
    w1(2,:)=(3-2*r(1)+q1)/8;
    w1(1,:)=(3-2*r(1)-q1)/8;
  %phi2
    q2=sqrt(1+4*r(2)*(1-r(2)));
    w2(:,4)=(1+2*r(2)-q2)/8;
    w2(:,3)=(1+2*r(2)+q2)/8;
    w2(:,2)=(3-2*r(2)+q2)/8;
    w2(:,1)=(3-2*r(2)-q2)/8;
  
  
  w=w1.*w2;
  f(i1,i2,1)=f(i1,i2,1)+(c*F(k,1))*w;
  f(i1,i2,2)=f(i1,i2,2)+(c*F(k,2))*w;
end

