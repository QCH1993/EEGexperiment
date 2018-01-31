function [ Mat_n ] = normalize_maxmin( Mat_data )
%NORMALIZE_MAXMIN Summary of this function goes here
%   Detailed explanation goes here
Vmax = max(max(Mat_data));
Vmin = min(min(Mat_data));
Mat_n = (Mat_data-Vmin)/(Vmax-Vmin);

end

