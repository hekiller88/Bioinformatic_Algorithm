function ret = rm_dup( arr )
% Description: remove duplicate element of an array
%              values having the same order
%              not using unique(data, 'stable')
% Example: r = rm_dup([1 2 2 3 1 2 2]) --> [1 2 3]
    
    arr_tmp = unique(arr);
    len = length(arr);
    ret = [];
    
    for i = 1:len
        if(ismember(arr(i),arr_tmp))
            ret = [ret arr(i)];
            arr_tmp = remv(arr(i), arr_tmp);
        end
    end

    end

    
% Description: remove the value(could be one or several) from an array
% Example: remv(3,[1,2,3,3,3,5]) -> [1,2,5]
function ret = remv(a, arr)
    ret = [];
    for i = 1:length(arr)
        if (a ~= arr(i))
            ret = [ret arr(i)];
        end
    end
    
end
