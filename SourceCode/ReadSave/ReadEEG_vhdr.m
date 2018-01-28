%----------------------------------------------------------------------
%FileName: ReadEEG_vhdr.m
%FunctionName: ReadEEG_vhdr
%Usage: read .eeg and .vmrk file through reading .vhdr file
%Author: Chen Qian
%Date: 2018-01-08
%----------------------------------------------------------------------

function [Mat_raw,config] = ReadEEG_vhdr( dir_path )
%ReadEEG_vhdr Summary of this function goes here
%   Detailed explanation goes here

% Read vhdr file to obtain the information of files
vhdr = dir([dir_path,'*.vhdr']);
vhdr_path = [dir_path, vhdr.name];
fp = fopen(vhdr_path);
if fp == -1
	error('ERR:ReadEEG_vhdr:FileNotReadable','Couldn''t read header file')
end
% read the whole file as one cell array
raw={};
while ~feof(fp)
    raw = [raw; {fgetl(fp)}];
end
fclose(fp);

% Remove comments and empty lines
raw(strmatch(';', raw)) = [];
raw(cellfun('isempty', raw) == true) = [];

n_line = length(raw);
for i=1:n_line
   if(strfind(raw{i},'='))
       S = regexp(raw(i),'=','split');
       switch (S{1}{1})
           case 'DataFile'
               config.eegName = S{1}{2};
           case 'MarkerFile'
               config.markName = S{1}{2};
           case 'NumberOfChannels'
               config.Nchannel = str2num(S{1}{2});
           case 'DataPoints'
               config.DataPoints = str2num(S{1}{2});
           case 'SamplingInterval'
               config.SamplingInterval = str2num(S{1}{2});
               config.SampleFrequency = 1000000/config.SamplingInterval;
           case 'BinaryFormat'
               config.BinaryFormat = S{1}{2};
       end
   end
end

% Read vmrk file to obtain mark information, we just get the start point.
mrk_path = [dir_path,config.markName];
fp = fopen(mrk_path);
if fp == -1
	error('ERR:ReadEEG_vhdr:FileNotReadable','Couldn''t read mark file')
end
% read the whole file as one cell array
raw={};
while ~feof(fp)
    raw = [raw; {fgetl(fp)}];
end
fclose(fp);

% Remove comments and empty lines
raw(strmatch(';', raw)) = [];
raw(cellfun('isempty', raw) == true) = [];

n_line = length(raw);
for i=1:n_line
   if(strfind(raw{i},'='))
       S = regexp(raw(i),'=','split');
       switch (S{1}{1}(1:2))
           case 'Mk'
               ss = regexp(S{1}{2},',','split');
               if (strcmp(ss(2),'256'))
                   config.startpoint = str2num(ss{3});
               end
               
       end
   end
end


%Read EEG file to obtain the IEEE_FLOAT32 data.
eeg_path = [dir_path,config.eegName];
bytesPerSample = 4;%ieeefloat32
binformat = 'float32';
if(config.BinaryFormat ~= 'IEEE_FLOAT_32')
    error('ERR: data binary format is not IEEE_FLOAT_32');
else
    % open file
    fp = fopen(eeg_path,'r');
    %seek to file end and get position in byte (total bytes in file)
    fseek(fp, 0, 'eof');
    totalBytes =  ftell(fp);

    % number of Frames 
    nFrames =  totalBytes / (bytesPerSample * config.Nchannel);

    %pre-allocate memory
    Mat_raw = single( zeros(config.Nchannel,nFrames) );
    %read
    frewind(fp);                
	Mat_raw = fread(fp, [config.Nchannel, nFrames], [binformat '=>float32']);
	fclose(fp);
    
end
    
Mat_raw(33:36,:)=[];
Mat_raw = double(Mat_raw);
end

