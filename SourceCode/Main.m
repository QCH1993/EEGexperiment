%----------------------------------------------------------------------
%FileName: Main
%
%Usage: main interface, all start from here  
%Author: Chen Qian
%Date: 2018-01-08
%----------------------------------------------------------------------

clc
clear

SourceDataPath = '../SourceData/';

% load eeg and track data
sample_path = [SourceDataPath,'HCII_datasets/20180125_zuoxuewen_F/']
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

%cut the first 5s and last 5s data and filter to delta\theta\alpha\beta\gamma
[prepare,prepare_delta,prepare_theta,prepare_alpha,prepare_beta,prepare_gamma] = EEGFilter_diffbands(EXP_prepare_f);
[easy,easy_delta,easy_theta,easy_alpha,easy_beta,easy_gamma] = EEGFilter_diffbands(EXP_easy_f);
[medium,medium_delta,medium_theta,medium_alpha,medium_beta,medium_gamma] = EEGFilter_diffbands(EXP_medium_f);
[hard,hard_delta,hard_theta,hard_alpha,hard_beta,hard_gamma] = EEGFilter_diffbands(EXP_hard_f);





