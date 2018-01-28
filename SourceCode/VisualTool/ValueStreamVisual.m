function [  ] = ValueStreamVisual(eeg )
%VALUEVISUAL Summary of this function goes here
%   Detailed explanation goes here

[row_eeg,col_eeg] = size(eeg);

[SensorLoc,SensorName]= ReadLoc();

eeg_max = max(max(eeg));
eeg_min = min(min(eeg));

x = SensorLoc(:,1);
y = SensorLoc(:,2);


for i = 1:400:col_eeg
    z = eeg(:,i);
    [X,Y,Z]=griddata(x,y,z,linspace(-1,1)',linspace(-1,1),'v4');
    pcolor(X,Y,Z)
    colormap jet
    shading interp
    caxis([eeg_min,eeg_max])
    
    colorbar 
    hold on 
    scatter(x,y,20,'k')
    text(SensorLoc(:,1),SensorLoc(:,2),SensorName,'fontsize',15)    

    set(gcf,'visible','off');   
     saveas(gcf,['../images/hard_theta/hard_zuoxuewen_',int2str(i)],'jpg');
end



% x=1:10;
% y=1:10;
% z = x.^2+y.^2;
% 
% [X,Y,Z]=griddata(x,y,z,linspace(0,10)',linspace(0,10),'v4');
% 
% 
%  pcolor(X,Y,Z)
%  shading interp
%  zmax=max(z);
%  zmin=min(z);
%  caxis([0,400])
%  colorbar
%  set(gcf,'visible','off');
%  i=1;
%  saveas(gcf,['./images/test',int2str(i)],'jpg');
%  delete(gcf)
%  figure,contourf(X,Y,Z)
%  figure,surf(X,Y,Z)
end

