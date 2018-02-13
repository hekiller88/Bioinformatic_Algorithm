function ret = pos_num( L )
% Description:amount of positive numbers in Data
% Example: r = pos_num([0 -1 2 3]) --> 2
  ret = sum(L>0);
end

