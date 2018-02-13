function tri = genTri(n)

    tri = []
    val = 0
    
    for i = 1:n
        val = val + i;
        tri = [tri val];
    end
    
end