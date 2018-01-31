function f = TimeFrequencyFeatureExtract( data )
f_HHS = HHS_extract(data);
f=f_HHS;

end

function f_HHS = HHS_extract(data)
[data_delta,data_theta,data_alpha,data_beta,data_gamma] = EEGFilter_diffbands_single(data);

Mat_freq = [data_delta;data_theta;data_alpha;data_beta;data_gamma];
f_HHS=[];
for i=1:5
    imf = emd(Mat_freq(i,:));
    for k = 1:length(imf)
        A(k) = sum(abs(hilbert(imf{k})).^2); 
    end
    f_HHS = [f_HHS,mean(A(k))];
    imf=[];
    
    A=[];
end
       
    
    
end
