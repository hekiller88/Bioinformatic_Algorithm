function ret = is_subset( arr1, arr2 )
% Description: test if A is a subset of B
% Input: A, B -- array
% Output: ret -- 1 if A is a subset of B, 0 otherwise
% Example: r = is_subset([2 3], [3,2,1]) --> 1
ret = 1;
for i = 1:length(arr1)
    if(~ismember(arr1(i),arr2))
        ret = 0; break;
    end
    
end

