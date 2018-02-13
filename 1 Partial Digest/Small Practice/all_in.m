function ret = all_in( arr1, arr2 )
% Input: A, B -- arrays
% Output: ret -- 1 if all element in A is in B, 0 otherwise
% Example: r = all_in([1 1 2], [1 2 3]) --> 0

for i = 1:length(arr1)
%     disp(['arr1: ',mat2str(arr1),'; ',num2str(arr1(i))]);
%     disp(['arr2: ',mat2str(arr2)]);
    if(ismember(arr1(i),arr2))
        ind = find(arr2 == arr1(i));
        arr2(ind(1)) = [];
        ret = 1;
    else
        ret = 0;
        break;
    end    
end


end



