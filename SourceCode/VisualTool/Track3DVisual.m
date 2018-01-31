function [  ] = Track3DVisual( track )
%TRACK3DVISUAL Summary of this function goes here
%   Detailed explanation goes here
orange = [237.6,29.7,-70];
purple = [165.0 150.4 -70];
pink = [188.7 -113.0 -70];
blue = [291.7 -50.0 -70];
green = [284.6 116.8 -70];

ColorPoint = [orange;purple;pink;blue;green];
ColorName = {'orange';'purple';'pink';'blue';'green'};

scatter3(track(1,:),track(2,:),track(3,:),'ko','MarkerFaceColor','y');
hold on 
plot3(orange(1),orange(2),orange(3),'ko','MarkerFaceColor',[1,0.5,0],'MarkerSize',20);
plot3(purple(1),purple(2),purple(3),'ko','MarkerFaceColor',[0.5,0.2,0.9],'MarkerSize',20);
plot3(pink(1),pink(2),pink(3),'ko','MarkerFaceColor',[1,0.75,0.75],'MarkerSize',20);
plot3(blue(1),blue(2),blue(3),'ko','MarkerFaceColor',[0,0,1],'MarkerSize',20);
plot3(green(1),green(2),green(3),'ko','MarkerFaceColor',[0,1,0],'MarkerSize',20);

text(ColorPoint(:,1),ColorPoint(:,2),ColorPoint(:,3)-10,ColorName,'fontsize',10);
text(track(1,1),track(2,1),track(3,1),{'start point'},'fontsize',10);
text(track(1,end),track(2,end),track(3,end),{'end point'},'fontsize',10);

end

