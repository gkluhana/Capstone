    % convert the image to a frame
% ib2D.m
% This script is the main program.
close all
clear all
clc

%T is location of target points
%delta, amprel, and freq are variables that prescrible the motion of the
%wing

global dt Nb N  h rho mu  a;
global Nx Ny ixp ixm iyp iym delta amprel freq num_flappers;
global kp km dtheta K T;


initialize
init_a

Trest = T(:,2);
snaptime = 50 ; %take snapshot after every snaptime 
sim_idx = 1;
simData = cell(ceil(clockmax/snaptime),4);
num_frames = 0;
for clock=1:clockmax
    time = clock*dt;
    XX=X+(dt/2)*interp(u,X);
    ff = spread(Force(XX),XX);
    T(:,2) =Trest - (delta/2 * ( amprel*sin(2*pi*freq*time)));
    [u,uu]=fluid(u,ff);
    X=X+dt*interp(uu,XX);
    %!!Change Place for Calculation of T
    
%   FLUX
%     fluxeval = Nx/8;
%     flux = sum(u(fluxeval,:,1))*h; %times mesh width, integral over L


%   fprintf('Simulation Time %d \n ',time)
  
% %   Change animation code to store data to file then plot simulation at the end
  if ~mod(clock,snaptime)
  vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
  simData(sim_idx,:) = [{vorticity}, {X} , {T} ,{time} ];
       if ~mod(clock,snaptime*10)
          num_frames = num_frames + 10;
          fprintf('Saved %d frames in SimData at Time %d \n ',num_frames,time)
       end
  sim_idx= sim_idx+1;
  end
%   vorticity=(u(ixp,:,2)-u(ixm,:,2)-u(:,iyp,1)+u(:,iym,1))/(2*h);
%   contour(xgrid,ygrid,vorticity,values)
%   hold on
%   plot(X(:,1),X(:,2),'ko')
%   for i =1:num_flappers
%      plot(T((i-1)*Nb+1:i*Nb,1),T((i-1)*Nb+1:i*Nb,2),'r-')
%   end
%   axis([0,Lx,0,Ly])
%   caxis(valminmax)
%   axis equal
%   drawnow
%    if ~mod(clock,snaptime*10)
%        saveas(gcf,'Figures/simulationSnap.jpg')
%    end
%   hold off
%     if ~mod(clock,snaptim)
%     fprintf('Flux is %d at Simulation Time %d \n',flux,clock*dt)
%     end
  %Save things then plot
 
end


%% PLOT Dumped Data

for i = 1: sim_idx-1
  vorticity = simData{i,1};
  X = simData{i,2};
  T = simData{i,3};
  time = simData{i,4};
  if i == 500 
  dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
  values= (-10*dvorticity):dvorticity:(10*dvorticity);
  valminmax=[min(values),max(values)];
  end
  plot(X(:,1),X(:,2),'kx')
  hold on
  if i> 500
  contour(xgrid,ygrid,vorticity,values);
  caxis(valminmax)
  end
  for j =1:num_flappers
     plot(T((j-1)*Nb+1:j*Nb,1),T((j-1)*Nb+1:j*Nb,2),'r-')
  end
  axis([0,Lx,0,Ly])
  axis equal
  if  ~mod(i,10)
      fprintf('Grabbing Frame %d \n',i)
  end
      set(gcf,'Position',[0 0 1500 500])
      F(i) = getframe(gcf) ;
%   drawnow
  hold off
end


     % create the video writer with 1 fps
  writerObj = VideoWriter('Figures/myVideo.avi');
  writerObj.FrameRate = 10;
  % set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(F)
    % convert the image to a frame
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);
