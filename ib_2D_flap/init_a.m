function a = init_a(param)
a=zeros(param.Nx,param.Ny,2,2);


for m1=0:(param.Nx-1)
  for m2=0:( param.Ny -1)
    a(m1+1,m2+1,1,1)=1;
    a(m1+1,m2+1,2,2)=1;
  end
end

for m1=0:(param.Nx-1)
  for m2=0:(param.Ny-1)
    if~(((m1==0)|(m1== param.Nx /2))&((m2==0)|(m2== param.Ny /2)))
      t=[(2*pi/param.Nx)*m1;(2*pi/param.Ny)*m2];
      s=sin(t);
      ss=(s*s')/(s'*s);
%     a(m1+1,m2+1,:,:)=a(m1+1,m2+1,:,:)-(s*s')/(s'*s);
      a(m1+1,m2+1,1,1)=a(m1+1,m2+1,1,1)-ss(1,1);
      a(m1+1,m2+1,1,2)=a(m1+1,m2+1,1,2)-ss(1,2);
      a(m1+1,m2+1,2,1)=a(m1+1,m2+1,2,1)-ss(2,1);
      a(m1+1,m2+1,2,2)=a(m1+1,m2+1,2,2)-ss(2,2);
    end
  end
end

for m1=0:(param.Nx-1)
  for m2=0:(param.Ny-1)
    t=[(pi/param.Nx)*m1;(pi/param.Ny)*m2];
    s=sin(t);
    a(m1+1,m2+1,:,:)=a(m1+1,m2+1,:,:)...
                    /(1+(param.dt/2)*(param.mu/param.rho)*(4/(param.h*param.h))*(s'*s));
  end
end

