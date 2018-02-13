
function [cstr sc pos] = BFMS1(DNA, lmer, iftrace)
% Name: BFMS1
%   Brute Force method to implement Motif Search
% Input:
%   DNA: the DNA sequences matrix
%   lmer: the length of motif
%   iftrace: using for Debugging
    
	disp('Algorithm 1 - Simple Brute Force Motif Search');
    
    % tic;
    
	[t n] = size(DNA);
    k = 4;      % the alphabet letters
    
    % initialize the first [1,1,...,1] motif
	s = ones(1, t);
	[bestScore ~] = score(s, DNA, lmer);
    sol = '';
    for i=1:length(s)
        sol = strcat(sol, sprintf(' %d', s(i)));
    end
    disp(sprintf('\tUpdate: bestScore =%3d  at  (%s )', bestScore, sol));
    
	while true
        tic;
        % get the new motifs
		s = nextleaf(s, t, n - lmer + 1);
		[newscore newCstr] = score(s, DNA, lmer);
        
        
        % Debugging, show details of every possible motif
		if iftrace == 1
            sol = '';
			for i=1:length(s)
				sol = strcat(sol, sprintf(' %d', s(i)));
            end           
            disp(sprintf('Pass candidate: (%s )', sol));
        end
        
        % update best score
		if newscore > bestScore
			bestScore = newscore;
			bestMotif = s;
            bestCstr = newCstr;
			sol = '';
			for i=1:length(s)
				sol = strcat(sol, sprintf(' %d', s(i)));
			end
			disp(sprintf('\tUpdate: bestScore =%3d  at  (%s )', bestScore, sol));
        end
        
        toc;
        
        % when it return to the original [1,1,1,...1], stop counting
		if s == ones(1, t)
            cstr = bestCstr;
            sc = bestScore;
            pos = bestMotif;
            
            sol = '';
			for i=1:length(pos)
				sol = strcat(sol, sprintf(' %d', pos(i)));
			end
            
            disp(sprintf('FINAL: cstr =%s bestScore =%3d at (%s )', cstr, sc, sol));
            
            %toc;
            return;
        end
        
        
    end
end


function str = printCsStr(s, DNA, l)
% Name: printCsStr
%   printout the consensus string 
% Input:
%    s : positions
%    DNA : DNA matrix
%    l : l-mer length
    
    p = profile_dna(s, DNA, l);
    str = profile2csStr(p);
    
end
            
function p = profile_dna(s, DNA, l) 
% Name: profile_dna
% Return profile given DNA, positions and length l
% Input:
%    s : positions
%    DNA : DNA matrix
%    l : l-mer length

    [t n] = size(DNA);
    
    alignment = ones(t, l);
  
    % Alignment Matrix
    for row = 1:t
        for col = 1:l           
            alignment(row, col) = DNA(row, s(row) + col - 1);
        end
    end
    
    alignment = char(alignment);
    
    % Profile Matrix
    rowA = []; rowT = []; rowG = []; rowC = [];
   
    for col = 1 : l
        A = 0; T = 0; G = 0; C = 0;
        
        for row = 1 : t
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


function str = profile2csStr(profile)
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
    

function leaf = nextleaf(a,L,k)
% Name: nextleaf
%   Same as Natrual counting
% Input:
%    a : input array, 
%        normally starting from [1,1,1,...,1] to [n,n,n,...n]
%    L : the arrays length
%    k : k-letter alphabet

	for i = L:-1:1
		if a(i) < k
			a(i) = a(i) + 1;
			leaf = a;
			return;
		else
			a(i) = 1;
		end
	end

	leaf = a;
    
end

function [sc cstr] = score(s, DNA, l)
% Name: score
%   Return consensus string and score given DNA and positions
% Input:
%    s : positions
%    DNA : DNA matrix
%    l : l-mer length
   
    p = profile_dna(s, DNA, l);
    
    sc = sum(max(p));
    cstr = printCsStr(s, DNA, l);
    
end
            
            

