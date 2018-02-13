
function [bd bw pos] = SPMS3( DNA, lmer, iftrace )
% Name: SPMS3
%   simple median search (P113)
% Input: 
%   DNA - DNA sequences matrix
%   lmer - the length of median string
%   iftrace - Using for debugging
% Output:
%   bd - best distance
%   bw - best word
%   pos - best starting postitions array

    tic;
    
    disp('Algorithm 3 - Simple Brute Force Median String Search');
    
    % initialization
    [t n] = size(DNA);
    word_s = ones(1, lmer);
    bestDis = intmax;
    bestWord = '';
    bestPos = [];
    
    i = 1;
    while i > 0
        if i < lmer
            if iftrace == 1
                disp(sprintf('Pass candidate: %s', num2atgc(word_s)));
            end
            [word_s, i] = nextvertex(word_s, i, lmer, 4);
        else
            word = num2atgc(word_s);
            [tmpPos, tmpDis] = totalDistance(word, DNA);
            if tmpDis < bestDis
                bestDis = tmpDis;
                bestWord = word;
                bestPos = tmpPos;
                disp(sprintf('\tUpdate: bestDist =%3d bestWord = %s at  (%s )', bestDis, word, printS(bestPos)));
            end
            [word_s, i] = nextvertex(word_s, i, lmer, 4);
        end
        
    end
    
    bd = bestDis;
    bw = bestWord;
    pos = bestPos;
    
    toc;
    
    disp(sprintf('FINAL: bestDist =%3d bestWord = %s at (%s )', bestDis, bestWord, printS(bestPos)));

end

function str = printS(s)
% Name: printS
%   print out the starting position array 
%   base on tree level/prefix
% Input:
%   s - starting position array
%   i - prefix || tree level, 
%       when setting as length(s) will print all s

    sol = '';
    for j = 1:length(s)
        sol = strcat(sol, sprintf(' %d', s(j)));
    end
    
    str = sol;
end

function str = num2atgc(mer)
% Name: num2actg
%   number to letter(A,C,T,G)
% Input:
%    str : 'atgca'
%    mer : [1,2,3,4,1] 
    
    result = '';
    
    for i = 1:length(mer)
        ele = mer(i);
        if ele == 1
            result = strcat(result,'A');
        elseif ele == 2
            result = strcat(result,'T');
        elseif ele == 3
            result = strcat(result,'G');
        else
            result = strcat(result,'C');
        end
    end
    
    str = result;
end

function [s_row, dis_row] = getBestMatchS_row(word, DNA, row)
% Name: getBestMatchS_row
%   get the best match between word and starting postition 
%   in the given row of DNA
% Input:
%   word - median string
%   DNA - DNA sequences matrix
%   row - given row

    [~,n] = size(DNA);
    l = length(word);
    DNA_row = DNA(row,:);
    bestHamDis = intmax;
    bestS = 0;
    
    for i = 1: n - l + 1
        tmpDis = getHammingDistance_row(word, i, DNA, row);
        if tmpDis < bestHamDis
            bestHamDis = tmpDis;
            bestS = i;
        end
    end
    
    s_row = bestS;
    dis_row = bestHamDis;
    
    
end

function dis = getHammingDistance_row(word, s_row, DNA, row)
% Name: getHammingDistance_row
%   get the Hamming Distance with given starting postition
%   in the given row of DNA
% Input:
%   word - median string
%   s_row - given statring position
%   DNA - DNA sequences matrix
%   row - given row

    l = length(word);
    DNA_row = DNA(row,:);
    tmpDis = 0;
    
    j = 1;
    for i = s_row: s_row + l - 1
        if ~strcmp(word(j), DNA_row(i))
            tmpDis = tmpDis + 1;
        end
        j = j + 1;
    end
    
    dis = tmpDis;

end

function [s, dis] = totalDistance(word, DNA)
% Name: totalDistance
%   get the best matched & minisit total hamming distace 
%           between word and DNA
% Input:
%   word - median string
%   DNA - DNA sequences matrix

    [t,n] = size(DNA);
    l = length(word);
    totalDis = 0;
    s_arr = [];
    
    for row = 1:t
        [tmpS_row, tmpDis_row] = getBestMatchS_row(word, DNA, row);
        s_arr = [s_arr,tmpS_row];
        totalDis = totalDis + tmpDis_row;
    end
    
    s = s_arr;
    dis = totalDis;
    
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
