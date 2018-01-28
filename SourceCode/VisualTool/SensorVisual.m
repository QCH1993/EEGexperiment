function [ SensorLoc,SensorName ] = SensorVisual()
%SENSORVISUAL Summary of this function goes here
%   Detailed explanation goes here
[SensorLoc,SensorName]= ReadLoc();
x=-1:0.01:1;
y1=sqrt(1-x.^2);
y2=-y1;
plot(x,y1);
hold on 
plot(x,y2);
z= -0.1:0.01:1;


end

