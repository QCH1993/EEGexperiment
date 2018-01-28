function  Mat_f = EEGFilter_butter(Mat,Fs,Fa,Fb)
%EEGFILTER_BUTTER Summary of this function goes here
%   Detailed explanation goes here
[Nchannels,Npoints] = size(Mat);
%time = 0:(1/Fs):(Npoints-1)*(1/Fs);
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
for i = 1:32
    Mat_f(i,:) = filter(b,a,Mat(i,:));
end
for i = 33:Nchannels
    Mat_f(i,:) = Mat(i,:);
end

end

