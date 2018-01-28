function Mat_merged = TimeCorrect(Mat_eeg,Mat_track)
%TIMECORRECT Summary of this function goes here
%   Detailed explanation goes here
rate = 50;
ind_eeg = find(Mat_eeg(33,:)==256,1,'first');
ind_track = find(Mat_track(5,:)==49,1,'first');

[Row_track,Col_track]=size(Mat_track);
[Row_eeg,Col_eeg]=size(Mat_eeg);


for i=1:Col_track
    
    for j=(i-1)*rate+1:i*rate
       track(1:4,j)=Mat_track(2:5,i); 
    end
    
end

ind_track_extend = (ind_track-1)*rate+1;

track_left = track(:,1:ind_track_extend-1);
track_right = track(:,ind_track_extend:end);
Mat_merged = zeros(Row_eeg+4,Col_eeg);
Mat_merged(1:33,:) = Mat_eeg;

%for left part
if (ind_eeg>=ind_track_extend)
    Mat_merged(34:end,ind_eeg-ind_track_extend+1:ind_eeg-1) = track_left;
else
    Mat_merged(34:end,1:ind_eeg-1)=track_left(:,ind_track_extend-ind_eeg+1:ind_track_extend-1);
end

%for right part
[Row_track_right,Col_track_right] = size(track_right);
if( Col_track_right > ( Col_eeg-ind_eeg+1))
    track_right_ = track_right(:,1:Col_eeg-ind_eeg+1);
end
if ( Col_track_right < ( Col_eeg-ind_eeg+1))
    track_right_ = [track_right, zeros(4,Col_eeg-ind_eeg+1 - Col_track_right)];
end
if (Col_track_right == ( Col_eeg-ind_eeg+1))
    track_right_ = track_right;
end
Mat_merged(34:end,ind_eeg:end) = track_right_;
Mat_merged(33,:) = Mat_merged(33,:)/256;
Mat_merged(end,:) = Mat_merged(end,:)-48;

Mat_merged([33,end],1:ind_eeg-1) = 0;
A = Mat_merged([33,end],:);
A(A<0 | A>9) = 0;
Mat_merged(33,:) = A(1,:);
Mat_merged(end,:) = A(2,:);

 
end

