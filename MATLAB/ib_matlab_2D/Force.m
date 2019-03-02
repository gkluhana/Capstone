function F=Force(X)
global kp km dtheta K T;

%F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
F = -K*(X-T);