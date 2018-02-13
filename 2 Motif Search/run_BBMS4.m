for i = 3:10
    disp(sprintf('BBMS4, DNA1, l =%3d',i));
    [cstr sc pos] = BBMS4(DNA1, i, 0);
end

for i = 3:10
    disp(sprintf('BBMS4, DNA2, l =%3d',i));
    [cstr sc pos] = BBMS4(DNA2, i, 0);
end