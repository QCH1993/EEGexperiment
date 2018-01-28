function Mat_track = ReadTrack_csv( dir_path )
%READTRACK_CSV Summary of this function goes here
%   Detailed explanation goes here
csv_dir = dir([dir_path,'*.csv']);
csv_path = [dir_path,csv_dir.name];
Mat = csvread(csv_path);

Mat_track = Mat';
end

