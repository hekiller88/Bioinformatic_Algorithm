function ret = is_palindrome( str )
% Input: str -- a string
% Output: ret -- 1 if str is a palindrome, 0 otherwise
% Display: YES / NO
% Example: r = is_palindrome('aabbcc') --> 0

str_flip = fliplr(str);

if(isequal(str,str_flip))
    ret = 1
    disp('Yes')
else
    ret = 0
    disp('No')
end

end

