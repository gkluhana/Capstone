%Plot Dumped Data
p = p; %Check for parameters existing.otherwise create again
% p = parameters()
xline   = p.Lx / 8;
xpoint  = xline  / (p.Lx/p.Nx);
flapper  = 'Variable';
filename = strcat(flapper,num2str(p.tmax),'s',num2str(p.gap),'.avi');
startVort = 250;
figure;
plotVorticity = 0;  %plot Vorticity switch
XTperiodic  %make X and T periodic for plotting
for i = 1:sim_idx-1
  X = simData{i,1};
  T = simData{i,2};
  time = simData{i,3};
  u_sim = simData{i,4};
  
  if plotVorticity 
	  %Start plotting vorticity after a while
 	 if i >= startVort
 		 vorticity=(u_sim(p.ixp,:,2)-u_sim(p.ixm,:,2)-u_sim(:,p.iyp,1)+u_sim(:,p.iym,1))/(2*p.h);
 	 if i == startVort
 		 dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
 		 values= -1*dvorticity:10:dvorticity;
 		 valminmax=[min(values),max(values)];
 	 end
 	 contour(p.xgrid,p.ygrid,vorticity,values);
 	 hold on
 	 end
  end
  %Plot Flappers and Target points
  plot(X(:,1),X(:,2),'kx')
  hold on
  
  for j =1:p.num_flappers
     plot(T((j-1)*p.Nb+1:j*p.Nb,1),T((j-1)*p.Nb+1:j*p.Nb,2),'r-')
  end
  
 
  %get flux data
  flux = sum(u_sim(xpoint,:,1));
  meanFlux = flux/p.Ly;
  %Format Plot
  axis equal manual
  xlim([0 p.Lx]);
  ylim([0 p.Ly]); 
  
  if plotVorticity
 	 if i >= startVort 
 	 caxis(valminmax)
 	 end
  end
  
  
  gap = Tail2Head(p,X);
  Info = {strcat(' Time:',num2str(time,4)),strcat(' dt:',num2str(p.dt)),strcat(' h:',num2str(p.h)), strcat(' Nx-Ny:',num2str(p.Nx),'-',num2str(p.Ny)),strcat(' K:',num2str(p.K)),strcat(' Flappers:',num2str(p.num_flappers)),strcat(' Gap:',num2str(gap)),strcat(' Nb:',num2str(p.Nb)),strcat(' Freq:',num2str(p.freq))};
  text(0,0.5*p.Ly,Info);
  
  
 line([xline,xline],[0,p.Ly],'LineStyle','--')
 FluxText = ['Net Flux:' num2str(flux,4) ' at x=' num2str(xline)];
 text(xline, 0.05*p.Ly,FluxText);
 
  if  ~mod(i,100)
      fprintf('Grabbing Frame %d \n',i)
  end
      set(gcf,'Position',[0 0 1500 500]);
      Frames(i) = getframe(gcf) ;
%   drawnow
  hold off
end

%create the video writer with 1 fps
  writerObj = VideoWriter(filename);
  writerObj.FrameRate = 50;
  % set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(Frames)
    % convert the image to a frame
    frame = Frames(i) ;
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);

