%----------------------------------------------------------------------
%FileName: SectionDivide
%
%Usage:   
%Author: Chen Qian
%Date: 2018-01-16
%----------------------------------------------------------------------
function [EXP_prepare,EXP_easy,EXP_medium,EXP_hard] = SectionDivide(Mat_merged)
%SECTIONDIVIDE Summary of this function goes here
%   Detailed explanation goes here
prepare = 1;
easy = 3;
medium = 5;
hard = 7;

EXP_prepare = Mat_merged([1:32,34:end],Mat_merged(end,:)==prepare);
EXP_easy = Mat_merged([1:32,34:end],Mat_merged(end,:)==easy);
EXP_medium = Mat_merged([1:32,34:end],Mat_merged(end,:)==medium);
EXP_hard = Mat_merged([1:32,34:end],Mat_merged(end,:)==hard);

end

