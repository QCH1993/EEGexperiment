function [eeg,track,data_delta,data_theta,data_alpha,data_beta,data_gamma] = EEGFilter_diffbands(EXP_data_f)
%dataFILTER_DIFFBANDS Summary of this function goes here
%   Detailed explanation goes here
[r,c] = size(EXP_data_f);
if (c>10000)
    data = EXP_data_f(:,2501:end-2500);
else
    data = EXP_data_f;
end

eeg = data(1:32,:);

if (r>32)
    track = data(33:end,:);
else
    track = 0;
end

[row,col] = size(eeg);
eeg_delta = zeros(row,col);
eeg_theta = zeros(row,col);
eeg_alpha = zeros(row,col);
eeg_beta = zeros(row,col);
eeg_gamma = zeros(row,col);
Fs = 500;

% delta
Fa = 1;
Fb = 4;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
for i = 1:32
    eeg_delta(i,:) = filter(b,a,eeg(i,:));
end
data_delta = eeg_delta;

% theta
Fa = 4;
Fb = 8;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
for i = 1:32
    eeg_theta(i,:) = filter(b,a,eeg(i,:));
end
data_theta = eeg_theta;

% alpha
Fa = 8;
Fb = 12;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
for i = 1:32
    eeg_alpha(i,:) = filter(b,a,eeg(i,:));
end
data_alpha = eeg_alpha;

% beta
Fa = 12;
Fb = 30;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
for i = 1:32
    eeg_beta(i,:) = filter(b,a,eeg(i,:));
end
data_beta = eeg_beta;

% delta
Fa = 30;
Fb = 64;
Wl = 2*Fa/Fs;
Wh = 2*Fb/Fs;
[b,a] = butter(4,[Wl,Wh]);
for i = 1:32
    eeg_gamma(i,:) = filter(b,a,eeg(i,:));
end
data_gamma = eeg_gamma;

end

