function [data_delta,data_theta,data_alpha,data_beta,data_gamma] = EEGFilter_diffbands_single(eeg) 
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% delta
Fs=500;

Fa = 1;
Fb = 4;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
data_delta  = filter(b,a,eeg );

% theta
Fa = 4;
Fb = 8;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
 data_theta = filter(b,a,eeg );
 

% alpha
Fa = 8;
Fb = 12;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
data_alpha =  filter(b,a,eeg );
 


% beta
Fa = 12;
Fb = 30;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
data_beta = filter(b,a,eeg );
 
   

% delta
Fa = 30;
Fb = 64;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
data_gamma = filter(b,a,eeg );
 


end

