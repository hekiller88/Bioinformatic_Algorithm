
for i = 5:10
    disp(sprintf('BFMS1, DNA1, l =%3d',i));
    [cstr sc pos] = BFMS1(DNA1, i, 0);
end

% for i = 3:10
%     disp(sprintf('BFMS1, DNA2, l =%3d',i));
%     [cstr sc pos] = BFMS1(DNA2, i, 0);
% end