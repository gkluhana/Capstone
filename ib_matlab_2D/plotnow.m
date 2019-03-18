%Plot Dumped Data

for i = 1:sim_idx-1
  vorticity = simData{i,1};
  X = simData{i,2};
  T = simData{i,3};
  time = simData{i,4};
  if i == 1000
  dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
  values= (-10*dvorticity):dvorticity:(10*dvorticity);
  valminmax=[min(values),max(values)];
  end
  if i> 1000
  contour(xgrid,ygrid,vorticity,values);
  hold on
  end
  plot(X(:,1),X(:,2),'kx')
  hold on
  for j =1:param.num_flappers
     plot(T((j-1)*param.Nb+1:j*param.Nb,1),T((j-1)*param.Nb+1:j*param.Nb,2),'r-')
  end
  axis equal manual
  xlim([0 3]);
  ylim([0 1]); 
  if i> 1000 
  caxis(valminmax)
  end
  title(['Time: ' num2str(time,4) ', dt:' num2str(param.dt) ', h:' num2str(param.h), ', Nx-Ny:', num2str(param.Nx) '-' num2str(param.Ny) ', Nb-202' ', Flappers:' num2str(param.num_flappers)])  
  if  ~mod(i,100)
      fprintf('Grabbing Frame %d \n',i)
  end
      set(gcf,'Position',[0 0 1500 500]);
      Frames(i) = getframe(gcf) ;
%   drawnow
  hold off
end

%create the video writer with 1 fps
  writerObj = VideoWriter('Figures/myVideo.avi');
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

