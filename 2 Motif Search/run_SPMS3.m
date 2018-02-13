
for i = 3:10
    disp(sprintf('SPMS3, DNA1, l =%3d',i));
    [cstr sc pos] = SPMS3(DNA1, i, 0);
end

for i = 3:10
    disp(sprintf('SPMS3, DNA2, l =%3d',i));
    [cstr sc pos] = SPMS3(DNA2, i, 0);
end