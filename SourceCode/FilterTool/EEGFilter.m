function Mat_f = EEGFilter( Mat, Fs,Fa,Fb, method )
%EEGFILTER Summary of this function goes here
%   Detailed explanation goes here

if(strcmp(method, 'butter'))
    Mat_f = EEGFilter_butter(Mat,Fs,Fa,Fb);
end

if( strcmp(method, 'FIR'))
    error('ERRO: FIR method is not implemented');
end


end

