%Plot Dumped Data
p = p; %Check for parameters existing.otherwise create again
% p = parameters()
xline   = p.Lx / 8;
xpoint  = ceil(xline  / (p.Lx/p.Nx));
front = fileName(p);
filename = strcat(front,'.avi');
startVort = 250;
figure;
if ~exist('plotVorticity')
	plotVorticity = 0;  %plot Vorticity switch, default for 0 if not specified by user
end

X = simData{1,1};
leader = 1:p.Nb;
if p.num_flappers > 1
    follower = p.Nb+1 :size(X,1);
end

%Trace
if ~exist('plotTrace')
    plotTrace = 1;  
end

if plotTrace
   maxTrace = 100;
   Tails = nan(maxTrace,2);
   [Tailx,tailIndex] = min(X(leader,1));
   Tails(1,:) = [X(tailIndex,1),X(tailIndex,2)];
       if p.num_flappers > 1
       Heads = nan(maxTrace,2);
       [Headx,headIndex] = max(X(follower,1));
       headIndex = headIndex+p.Nb;
       Heads(1,:) = [X(headIndex,1),X(headIndex,2)];
    end
end

%XTperiodic  %make X and T periodic for plotting
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
  plot(mod(X(leader,1),p.Lx),X(leader,2),'ko')
  hold on
  
  if p.num_flappers > 1
        plot(mod(X(follower,1),p.Lx),X(follower,2),'ro')
  end
  
  
  for j =1:p.num_flappers
     plot(mod(T((j-1)*p.Nb+1:j*p.Nb,1),p.Lx),T((j-1)*p.Nb+1:j*p.Nb,2),'bo','MarkerSize',0.8)
  end
  

  
  %get flux data
  flux = sum(u_sim(xpoint,:,1));
  meanFlux = flux/p.Ly;
  %Format Plot
  axis equal manual
  xlim([0 p.Lx]);
  ylim([5 20]); 
  
  if plotVorticity
 	 if i >= startVort 
 	 caxis(valminmax)
 	 end
  end
  
  if plotTrace
     if i > maxTrace
           Tails = [Tails(2:end,:); X(tailIndex,1),X(tailIndex,2)];
     else
            Tails(i,:) = [X(tailIndex,1),X(tailIndex,2)];
     end
     plot(mod(Tails(:,1),p.Lx),Tails(:,2),'ko','MarkerSize',0.8)
      if p.num_flappers > 1
          if i > maxTrace
             Heads = [Heads(2:end,:); X(headIndex,1),X(headIndex,2)];
          else
              Heads(i,:) = [X(headIndex,1),X(headIndex,2)];
          end
      plot(mod(Heads(:,1),p.Lx),Heads(:,2),'ro','MarkerSize',0.8)
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
%      set(gcf,'Position',[0 0 1500 500]);
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

