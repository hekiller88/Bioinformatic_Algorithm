function arr_output = remove( arr1, arr2 )
% remove every element of A from B, ALSO, DO NOT CHANGE B after function call!
% Input: A, B
% Output: ret
% Example: r = remove([1,1], [1,2,1,2]) --> [2 2] 

for i = 1:length(arr1)
    for j = 1:length(arr2)
        if(arr1(i) == arr2(j))
            arr2(j) = [];
            break;
        end            
    end
end

arr_output = arr2;

end

