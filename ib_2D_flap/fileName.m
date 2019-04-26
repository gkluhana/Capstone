function name = filename(p)

%Make a filename for the plots
Node = '-hpc-';

name = strcat('Sim',Node,'Tmax',num2str(p.tmax),'s','f',num2str(p.freq),'N',num2str(p.N),'mu',num2str(p.mu),'AC',num2str(p.AoverC),'gap',num2str(p.Tail2Head),'dt',num2str(p.dt))
