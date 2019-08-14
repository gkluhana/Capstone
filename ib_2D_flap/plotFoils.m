
plot(X(1:p.Nb,1),X(1:p.Nb,2),'ko','MarkerSize',0.7)
hold on

plot(X(1+p.Nb:p.Nb+p.Nb,1),X(1+p.Nb:p.Nb+p.Nb,2),'ro','MarkerSize',0.7)

% plot(T(:,1),T(:,2),'ro', 'MarkerSize',1)


% quiver([58], [14],[0],[1.5],'k')
% quiver([48], [14],[0],[1.5],'k')
% 
% quiver([58], [13],[0],[-1.5],'k')
% quiver([48], [12.8],[0],[-1.3],'k')
%Check Initial Configuration of system
line([p.xcenter(2)+2 p.xcenter(1)-2],[14+5 14+5],'Color','black')
line([p.xcenter(2)+2 p.xcenter(2)+2],[13.9+5 14.1+5],'Color','black')
line([56 56],[13.9+5 14.1+5],'Color','black')
g = 'Tail-to-Head gap, \it g';
text(52.8,14.1+6,g,'Interpreter','latex','FontSize',16,'HorizontalAlignment','center');
line([p.xcenter(2)-2 p.xcenter(2)+2],[13-5 13-5],'Color','black')
line([p.xcenter(2)+2 p.xcenter(2)+2],[12.9-5 13.1-5],'Color','black')
line([p.xcenter(2)-2 p.xcenter(2)-2],[12.9-5 13.1-5],'Color','black')
chord = 'Chord length, \it c';
text(p.xcenter(2),13.1-6,chord,'Interpreter','latex','FontSize',16,'HorizontalAlignment','center');
line([60.5+0.5 60.5+0.5],[11.7 15.3],'Color','black')
line([60.2+0.5 60.8+0.5],[11.7 11.7],'Color','black')
line([60.2+0.5 60.8+0.5],[15.3 15.3],'Color','black')
amp = 'Peak-to-Peak Amplitude,\it A';
text(62,13.5,amp,'Interpreter','latex','FontSize',16);

line([p.xcenter(2)-2 p.xcenter(2)-2],[13.1-5 13.5],'Color',[0.2 0.2 0.2],'LineStyle',':')

 line([p.xcenter(2)+2 p.xcenter(2)+2],[13.1-5 13.5],'Color',[0.2 0.2 0.2],'LineStyle',':')


line([p.xcenter(2)+2 p.xcenter(2)+2],[13.9+5 13.5],'Color',[0.2 0.2 0.2],'LineStyle',':')

line([p.xcenter(1)-2 p.xcenter(1)-2],[13.9+5 13.5],'Color',[0.2 0.2 0.2],'LineStyle',':')


x= 0:0.1:47;
y = 1.9*sin((x+3)*pi/5-10*pi/5)+13.5;
plot(x,y,'r-');
x= 0:0.1:56;
y = 1.9*sin((x+4)*pi/5)+13.5;
plot(x,y,'k--');


xlim([0 p.Lx]);
ylim([0 p.Ly]);
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
set(gca,'Visible','off')
axis equal