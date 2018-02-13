function [even,odd] = even_odd( n )
%   Description: test if a number is even/odd
%   Example: [e o] = even_odd(4) --> e<-1, o<-0
    if(~mod(n,2))
       even = 1; odd = 0;
    else
       even = 0; odd = 1;
    end
end

