%% call after computations

fprintf('Making X and T periodic...\n')
XTperiodic;
fprintf('Making Pictures...\n')
makePictures;
plotGap;
fprintf('Saving Data...\n')
saveData
fprintf('Plotting Video...\n')
plotVorticity = input('Do you want to plot Vorticitiy?\n 1:yes, 0:no');
plotnow

