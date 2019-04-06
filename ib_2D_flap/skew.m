function w=skew(param,u)
w=u; %note that this is done only to make w the same size as u


g1 = u(:,:,1);

%following was originally evaluated in sk
w(:,:,1)=((u(param.ixp,:,1)+u(:,:,1)).*g1(param.ixp,:)...
  -(u(param.ixm,:,1)+u(:,:,1)).*g1(param.ixm,:)...
  +(u(:,param.iyp,2)+u(:,:,2)).*g1(:,param.iyp)...
  -(u(:,param.iym,2)+u(:,:,2)).*g1(:,param.iym))/(4*param.h);

g2 = u(:,:,2);

%following was originally evaluated in sk
%NOTE, REPEATED CODE

w(:,:,2)=((u(param.ixp,:,1)+u(:,:,1)).*g2(param.ixp,:)...
  -(u(param.ixm,:,1)+u(:,:,1)).*g2(param.ixm,:)...
  +(u(:,param.iyp,2)+u(:,:,2)).*g2(:,param.iyp)...
  -(u(:,param.iym,2)+u(:,:,2)).*g2(:,param.iym))/(4*param.h);





