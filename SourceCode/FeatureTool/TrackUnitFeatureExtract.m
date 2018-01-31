function [ Features ] = TrackUnitFeatureExtract(track_unit,k )
%TRACKUNITFEATUREEXTRACT Summary of this function goes here
%   Detailed explanation goes here
 
if nargin==1,k = 500;end
[row_track,col_track]=size(track_unit);
 count = 0;
%  k=200;
% detect the changes of direction as smoothness
for i = k+1:k:col_track-k
    p_now = track_unit(:,i);
    p_before = track_unit(:,i-k);
    p_next = track_unit(:,i+k);
    
    diff0 = p_now-p_before;
    diff1 = p_next-p_now;
     
    costheta = dot(diff0,diff1)/norm(diff0,2)/norm(diff1,2);
    theta = rad2deg(acos(costheta));
    theta = abs(theta);
    if (theta>45)
        count = count+1;
    end
    
end

Features = count;

end

