function [ eeg_feature ] = eegUnitFeatureExtract( eeg_unit )
%EEGUNITFEATUREEXTRACT Summary of this function goes here
%   Detailed explanation goes here
[eeg,~,eeg_delta,eeg_theta,eeg_alpha,eeg_beta,eeg_gamma] = EEGFilter_diffbands(eeg_unit);
Time_feature=[];
Frequency_feature=[];
TimeFrequency_feature=[];
for i=1:32
    Time_feature = [Time_feature,TimeFeatureExtract(eeg(i,:))];
    Frequency_feature = [Frequency_feature,FrequencyFeatureExtract(eeg(i,:))];
    TimeFrequency_feature = [TimeFrequency_feature,TimeFrequencyFeatureExtract(eeg(i,:))];
end

eeg_feature = [Time_feature,Frequency_feature,TimeFrequency_feature];

end

