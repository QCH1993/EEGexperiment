function [ eegFeatureMap,trackLabel ] = FeatureExtract( ExpName,eeg,track,stride,N_window)
%FeatureExtract Summary of this function goes here
%   Detailed explanation goes here
%   Sliding window realization and send the slided data to
%   eegUnitFeatureExtract().
[row_eeg,col_eeg] = size(eeg);
 
eegFeatureMap=[];
trackUnitFeature=[];

for i=1:stride:col_eeg-N_window
     
    eeg_now = eeg(:,i:i+N_window-1);
    track_now = track(:,i:i+N_window-1);
    eegFeatureMap = [eegFeatureMap; eegUnitFeatureExtract(eeg_now)];
    trackUnitFeature = [trackUnitFeature; TrackUnitFeatureExtract(track_now)];
   i
    
end
 

[N_data,~] = size(trackUnitFeature);

if(strcmp(ExpName,'easy'))
    trackExpFeature = 2.5;
end
if(strcmp(ExpName,'medium'))
    trackExpFeature = 4;
end
if(strcmp(ExpName,'hard'))
    trackExpFeature = 5.5;
end
trackExpFeatureMap = repmat(trackExpFeature,N_data,1);

vmax = max(max(trackUnitFeature));
vmin = min(min(trackUnitFeature));
trackUnitFeature = (trackUnitFeature-vmin)/(vmax-vmin)*3-1.5;

trackFeatureMap = [trackExpFeatureMap,trackUnitFeature];
%caculate scores TODO
trackLabel = sum(trackFeatureMap,2) ;
end
