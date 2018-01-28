clc
clear
Fs = 1000;
Fa = 50;
Fb = 200;
x = 0:0.001:1;
y1 = sin(2*pi*10*x);
y2 =  0.001*sin(2*pi*100*(x+0.1));
y3 =  sin(2*pi*400*x);
y4 = x*2;
y=y2+y3+y4;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);

yy = filter(b,a,y);
plot(x,y)
figure
plot(x,yy)