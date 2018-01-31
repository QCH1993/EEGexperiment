%----------------------------------------------------------------------
%FileName:FeatureExtract
%FunctionName:    f_mean = mean(data);
%                 f_power = power_demo(data);
%                 f_standard_deviation = standard_deviation(data);
%                 f_diff1 = diff1(data);
%                 f_normalized_diff1 = normalized_diff1(data);
%                 f_diif2 = diff2(data);
%                 f_normalized_diff2 = normalized_diff2(data);
%Usage:Extract Time_Feature of EEG signal for each data.
%      Return a value or a vector
%Author: Chen Qian
%Date: 2017-04-25
%----------------------------------------------------------------------
% data must be a 1*N mat


function f = TimeFeatureExtract(data)
    f_mean = mean(data);
    f_power = power_demo(data);
    f_standard_deviation = standard_deviation(data);
    f_diff1 = diff1(data);
    f_normalized_diff1 = normalized_diff1(data);
    f_diif2 = diff2(data);
    f_normalized_diff2 = normalized_diff2(data);
    
    static_feature = [f_mean, f_power, f_standard_deviation, f_diff1, f_normalized_diff1, f_diif2, f_normalized_diff2];
    f_HOC = HOC(data);
    f_FD = FD(data);
    f = [static_feature,f_HOC,f_FD];
end

function f_FD = FD(data)
    [~,N] = size(data);
    k_max = floor(log(N)/log(2));
    M=[];
    for k = 2:k_max
        L=[];
        for m=1:k-1
            series=data(m:k:N);
            [~,N_series] = size(series);
            L(m) = (N-1)/N_series/k/k*sum(abs(diff(series)));
        end
        M(k) = mean(L(m));
    end
    
    R = polyfit((2:k_max),-log(M(1,2:end)),1);
    f_FD = R(1)/log(2);
end

function f_HOC = HOC(data)
    f_HOC = [sum(data(1:end-1) > 0 & data(2:end) < 0)];
    for i=1:9
        delta = diff(data,i);     
        f_HOC = [f_HOC,sum(delta(1:end-1) > 0 & delta(2:end) < 0)];
    end

end

function  f_power = power_demo(data)
    [row,col] = size(data);
    f_power = 0;
    for i = 1:row
        for j = 1:col
            f_power = f_power + data(i,j)^2;
        end
    end
end


function f_standard_deviation = standard_deviation(data)
    [row,col] = size(data);
    mean_data = mean(data);
    Sum = 0;
    for i = 1:col
        Sum = Sum + (data(i)-mean_data).^2;
    end 
    f_standard_deviation = sqrt(Sum./col);
end

function f_diff1 = diff1(data)
    [row,col] = size(data);
    Sum = 0;
    for i = 1:col-1
        Sum = Sum + abs(data(i)-data(i+1));
    end
    f_diff1 = Sum./(col-1);
end 

function f_normalized_diff1 = normalized_diff1(data)
    f_diff1 = diff1(data);
     f_standard_deviation = standard_deviation(data);
     f_normalized_diff1 = f_diff1./f_standard_deviation;
end

function f_diff2 = diff2(data)
    [row,col] = size(data);
    Sum = 0;
    for i = 1:col-2
        Sum = Sum + abs(data(i)-data(i+2));
    end
    f_diff2 = Sum./(col-2);
end 

function f_normalized_diff2 = normalized_diff2(data)
    f_diff2 = diff2(data);
     f_standard_deviation = standard_deviation(data);
     f_normalized_diff2 = f_diff2./f_standard_deviation;
end









