clc
clear

SourceDataPath = '../SourceData/HCII_datasets/';

% load eeg and track data
file = dir(SourceDataPath);


MyPar = parpool;
parfor i=3:length(file)
    
    sample_path = [SourceDataPath,file(i).name,'/']
    [Mat_eeg,config] = ReadEEG(sample_path,'vhdr');
    Mat_track = ReadTrack_csv(sample_path);
    % load electrodes position
    [SensorLoc,SensorName]= ReadLoc();

    % Time calibration
    Mat_merged = TimeCorrect(Mat_eeg,Mat_track);
    % Seperation of different mode
    [EXP_prepare,EXP_easy,EXP_medium,EXP_hard] = SectionDivide(Mat_merged);

    % Filter out 1-64Hz signal for advanced process
    Fs = config.SampleFrequency;
    Fa = 1;
    Fb = 64;
    EXP_prepare_f = EEGFilter(EXP_prepare,Fs,Fa,Fb,'butter');
    EXP_easy_f = EEGFilter(EXP_easy,Fs,Fa,Fb,'butter');
    EXP_medium_f = EEGFilter(EXP_medium,Fs,Fa,Fb,'butter');
    EXP_hard_f = EEGFilter(EXP_hard,Fs,Fa,Fb,'butter');
 
    %TODO:data cut and data normalization of each channel to 0-1(max-min)
    EXP_prepare_c=  EXP_prepare(:,2500:end-2500);
    EXP_easy_c =  EXP_easy(:,2500:end-2500);
    EXP_medium_c = EXP_medium(:,2500:end-2500);
    EXP_hard_c = EXP_hard(:,2500:end-2500);

    EXP_prepare_n = normalize_maxmin( EXP_prepare_c(1:32,:) );
    EXP_easy_n=  normalize_maxmin(EXP_easy_c(1:32,:));
    EXP_medium_n = normalize_maxmin(EXP_medium_c(1:32,:));
    EXP_hard_n = normalize_maxmin(EXP_hard_c(1:32,:));

    track_prepare =  EXP_prepare_c(33:end,:) ;
    track_easy =  EXP_easy_c(33:end,:);
    track_medium = EXP_medium_c(33:end,:);
    track_hard = EXP_hard_c(33:end,:);
    %TODO:data FeatureExtract
    stride=100;
    window=5000;
    tmp=zeros(1);
    [ eegFeatureMap_easy,trackLabel_easy ]=FeatureExtract('easy',EXP_easy_n,track_easy ,stride,window);
    [ eegFeatureMap_medium,trackLabel_medium ]=FeatureExtract(EXP_medium_n,'hard',track_medium ,stride,window);
    [ eegFeatureMap_hard,trackLabel_hard ]=FeatureExtract(EXP_hard_n,'hard',track_hard ,stride,window);
    
    m=matfile(sprintf([file(i).name,'.mat']),'writable',true)
    m.eegFeatureMap_easy=eegFeatureMap_easy;
    m.trackLabel_easy=trackLabel_easy;
    m.eegFeatureMap_medium=eegFeatureMap_medium;
    m.trackLabel_medium=trackLabel_medium;
    m.eegFeatureMap_hard=eegFeatureMap_hard;
    m.trackLabel_hard=trackLabel_hard;
    
    
    %TODO:Feature Selection
    %TODO:regression analysis

    %cut the first 5s and last 5s data and filter to delta\theta\alpha\beta\gamma
    % [prepare,track_prepare,prepare_delta,prepare_theta,prepare_alpha,prepare_beta,prepare_gamma] = EEGFilter_diffbands(EXP_prepare_f);
    % [easy,track_easy, easy_delta,easy_theta,easy_alpha,easy_beta,easy_gamma] = EEGFilter_diffbands(EXP_easy_f);
    % [medium,track_medium, medium_delta,medium_theta,medium_alpha,medium_beta,medium_gamma] = EEGFilter_diffbands(EXP_medium_f);
    % [hard,track_hard, hard_delta,hard_theta,hard_alpha,hard_beta,hard_gamma] = EEGFilter_diffbands(EXP_hard_f);

end
delete(MyPar);


% fs = 1000;
% t = 0:1/fs:2;
% y = sin(128*pi*t) + sin(256*pi*t);      
% 
% figure;
% win_sz = 128;
% han_win = hanning(win_sz);      % 选择海明窗
% 
% nfft = win_sz;
% nooverlap = win_sz - 1;
% [S, F, T] = spectrogram(y, window, nooverlap, nfft, fs);
% 
% imagesc(T, F, log10(abs(S)))
% set(gca, 'YDir', 'normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('short time fourier transform spectrum')

% plot 4 mission k choose reason
% i=1;
% for k= 1:10:10000
%     l(i)= TrackUnitFeatureExtract(track_easy(1:3,:),k);
%     o(i)= TrackUnitFeatureExtract(track_medium(1:3,:),k);
%     p(i)= TrackUnitFeatureExtract(track_hard(1:3,:),k);
%     q(i)= TrackUnitFeatureExtract(track_prepare(1:3,:),k);
%     i=i+1;
% end
% plot(l);
% hold on
% plot(o);
% hold on
% plot(p);
% hold on 
% plot(q);

% clear
% Main
% i=1;
% for k = 1:10:35000
%     l(i) = TrackUnitFeatureExtract(track_medium(:,k:k+5000) );
%     i=i+1;
% end
% plot(l)

% Fs = 1000;
% Fa = 50;
% Fb = 200;
% x = 0:0.001:1;
% y1 = sin(2*pi*10*x);
% y2 =  0.001*sin(2*pi*100*(x+0.1));
% y3 =  sin(2*pi*400*x);
% y4 = x*2;
% y=y2+y3+y4;
% Wl = 2*Fa/Fs;
% Wh = 2*Fb/Fs;
% [b,a] = butter(4,[Wl,Wh]);
% 
% yy = filter(b,a,y);
% plot(x,y)
% figure
% plot(x,yy)

% 
% x = gpuArray.randn(32,1);
% y = gpuArray.randn(32,1);
% z = (x-0.5).^2 + (y-0.5).^2;
% lin = gpuArray(linspace(0,1));
% xx=reshape(x,4,8);
% yy=reshape(y,4,8);
% zz=reshape(z,4,8);
% x0 = randn(32,1);
% y0 = randn(32,1);
% z0 = randn(32,1);
% tic
% [X,Y,Z]=griddata(x0,y0,z0,linspace(0,1)',linspace(0,1),'v4');
% toc

% pcolor(xx,yy,zz)
% colormap jet
% shading interp
% caxis([eeg_min,eeg_max])
% 
% colorbar 
% hold on 
% scatter(x,y,20,'k')
% text(SensorLoc(:,1),SensorLoc(:,2),SensorName,'fontsize',15)    
% 
% set(gcf,'visible','off');   
%  saveas(gcf,['../images/hard_theta/hard_zuoxuewen_',int2str(i)],'jpg');