%----------------------------------------------------------------------
%FileName: ReadEEG.m
%FunctionName: ReadEEG
%Usage:  read eeg file by selected method.
%Author: Chen Qian
%Date: 2018-01-08
%----------------------------------------------------------------------

function [Mat,config]  = ReadEEG( dir_path, method )
%READEEG Summary of this function goes here
%   Detailed explanation goes here
 
if (strcmp(method,'vhdr'))
    [Mat,config] = ReadEEG_vhdr(dir_path);
else
    error('ERRO: other format reading methods are not implemented');
end



end

