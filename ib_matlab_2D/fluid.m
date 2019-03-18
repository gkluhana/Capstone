function [uuu,uu]=fluid(param,u,ff)
% global a dt rho mu;
w=u-(param.dt/2)*skew(param,u)+(param.dt/(2*param.rho))*ff;

w=fft(w,[],1);
w=fft(w,[],2);
uu(:,:,1)=param.a(:,:,1,1).*w(:,:,1)+param.a(:,:,1,2).*w(:,:,2);
uu(:,:,2)=param.a(:,:,2,1).*w(:,:,1)+param.a(:,:,2,2).*w(:,:,2);
uu=ifft(uu,[],2);
uu=real(ifft(uu,[],1));

%Originally computed in laplacian.m
laplacian=(u(param.ixp,:,:)+u(param.ixm,:,:)+u(:,param.iyp,:)+u(:,param.iym,:)-4*u)/(param.h*param.h);


w=u-param.dt*skew(param,uu)+(param.dt/param.rho)*ff+(param.dt/2)*(param.mu/param.rho)*laplacian;
w=fft(w,[],1);
w=fft(w,[],2);
uuu(:,:,1)=param.a(:,:,1,1).*w(:,:,1)+param.a(:,:,1,2).*w(:,:,2);
uuu(:,:,2)=param.a(:,:,2,1).*w(:,:,1)+param.a(:,:,2,2).*w(:,:,2);
uuu=ifft(uuu,[],2);
uuu=real(ifft(uuu,[],1));
