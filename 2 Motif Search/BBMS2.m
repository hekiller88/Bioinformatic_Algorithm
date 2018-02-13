
function [cstr sc pos] = BBMS2(DNA, lmer, iftrace)
% Name: BFMS2
%   Branch and  Bound Motif Search(P111)
% Input:
%   DNA: the DNA sequences matrix
%   lmer: the length of motif
%   iftrace: using for Debugging

    tic;
    
    disp('Algorithm 2 - Branch and Bound Motif Search');

    [t n] = size(DNA);
    k = n - lmer + 1;
    s = ones(1, t);
    bestScore = 0;
    bestCstr = '';
    bestMotif = [];
    
    i = 1;      % tree level
    while i > 0
        if i < t            
            [tmpScore,~]  = score(s,i, DNA, lmer) ;
            optScore = tmpScore + (t - i)*lmer;
            if optScore < bestScore                
                if iftrace == 1
                    disp(sprintf('Bypass candidate: (%s )', printS(s,i)));
                end
                [s,i] = bypass(s, i, t, k);
            else
                if iftrace == 1
                    disp(sprintf('  Pass candidate: (%s )', printS(s,i)));
                end
                [s,i] = nextvertex(s, i, t, k);                
            end
        else
            [tmpScore, tmpCstr] = score(s,t, DNA, lmer);
            if tmpScore > bestScore
                bestScore = tmpScore;
                bestMotif = s;
                bestCstr = tmpCstr;            
                disp(sprintf('\tUpdate: bestScore =%3d  at  (%s )', bestScore, printS(s,t)));
            end
            [s,i] = nextvertex(s, i, t, k);
        end
    end
    
    cstr = bestCstr;
    sc = bestScore;
    pos = bestMotif;
    
    disp(sprintf('FINAL: cstr =%s bestScore =%3d at (%s )', cstr, sc, printS(pos,t)));
    
    toc;

end            

function str = printS(s, i)
% Name: printS
%   print out the starting position array 
%   base on tree level/prefix
% Input:
%   s - starting position array
%   i - prefix || tree level, 
%       when setting as length(s) will print all s

    sol = '';
    for j = 1:length(s)
        if j <= i
            sol = strcat(sol, sprintf(' %d', s(j)));
        else
            sol = strcat(sol, ' - ');
        end
    end
    
    str = sol;
end

function p = profile_dna(s, i, DNA, l) 
% Name: profile_dna
%   Return profile given DNA, positions and length l
% Input:
%    s : positions
%    DNA : DNA matrix
%    l : l-mer length

    [~,n] = size(DNA);
    
    alignment = ones(i, l);
  
    % Alignment Matrix
    for row = 1:i
        for col = 1:l
            alignment(row, col) = DNA(row, s(row) + col - 1);
        end
    end
    
    alignment = char(alignment);
    
    % Profile Matrix
    rowA = []; rowT = []; rowG = []; rowC = [];
   
    for col = 1 : l
        A = 0; T = 0; G = 0; C = 0;
        
        for row = 1 : i
            ele = alignment(row,col);
            if(strcmp(ele,'A'))
                A = A + 1;
            elseif(strcmp(ele,'T'))
                T = T + 1;
            elseif(strcmp(ele,'G'))
                G = G + 1;
            else
                C = C + 1;
            end
            
        end
        rowA = horzcat(rowA,A);
        rowT = horzcat(rowT,T);
        rowG = horzcat(rowG,G);
        rowC = horzcat(rowC,C);
    end
    
    p = [rowA; rowT; rowG; rowC];
       
end

function str = profile2cstr(profile)
% Name: profile2csStr
%   input profile matrix, get the consensus string
% Input:
%   profile - profile matrix

    [rowMax colMax] = size(profile);
    
    strTmp = '';
    
    x = [];
    for col = 1:colMax
        x = find(profile(:,col) == max(profile(:,col)));
        % 1 - A, 2 - T, 3 - G, 4 - C
        if x == 1
            strTmp = strcat(strTmp, 'A');
        elseif x == 2
            strTmp = strcat(strTmp, 'T');
        elseif x == 3
            strTmp = strcat(strTmp, 'G');
        else
            strTmp = strcat(strTmp, 'C');
        end
    end
    
    str = strTmp;
    
end

function [out level] = nextvertex(a,i,L,k)
% Name: nextvertex
%   go to next children tree node
% Input:
%    a : instance a=(a1a2...aL)
%    i : tree level 
%    L : L-mer
%    k : k-letter alphabet

    if i < L
        a(i+1) = 1; 
        out = a; level = i+1;
        return;
    else
        for j = L:-1:1
            if a(j) < k
                a(j) = a(j) + 1;
                out = a; level = j;
                return;
            end
        end
    end
    
    out = a; level = 0; 
    return;
                
end

function [out level] = bypass(a,i,L,k)
% Name: bypass
%   ignore input tree node's children, 
%   go to next node which is in the same tree level
% Input:
%    a : instance a=(a1a2...aL)
%    i : tree level 
%    L : L-mer
%    k : k-letter alphabet

   for j = i:-1:1
       if a(j) < k
           a(j) = a(j) + 1;
           out = a; level = j;
           return;
       end
   end
   
   out = a; level = 0;
   return;
           
end

function [sc cstr] = score(s, i, DNA, l)
% Name: score
%   Return consensus string and score given DNA and positions
% Input:
%    s : positions
%    DNA : DNA matrix
%    l : l-mer length
   
    p = profile_dna(s, i, DNA, l);
    
    sc = sum(max(p));
    cstr = profile2cstr(p);
    
    
end
