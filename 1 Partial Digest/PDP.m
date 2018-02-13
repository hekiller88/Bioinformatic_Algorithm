% PDP 
% 
function PDP(L, iftrace)
% Description: Given all pairwise distances between points on a line, 
%              reconstruct the positions of those points.
% Input: L is the input partial digest, 
%        iftrace is for triggering trace log
% Output: complete digest

    str = ['L = ', mat2str(L),' when Traced?'];
    
    if(iftrace)
        disp(strcat(str,' is checked'));
    else 
        disp(strcat(str,' is unchecked'));
    end

	L = sort(L);        % make L sorted for easy implementation

	width = max(L);     % width is the maximum element of L
	L(L == width) = [];	% delete(width, L)
	X = [0 width];

	PLACE(L, X, width, 0, iftrace);
end


function PLACE(L, X, width, level, iftrace)
% Description: helper function for PDP
% Input: L is the input partial digest, 
%        X is the complete digest produces
%        width is the length of the partial digest,
%        level is used for trace log
%        iftrace is for triggering trace log
    
    %indicate the search tree level now
    indent = '----';
	for i=1:level
		indent = strcat(indent, ' ----');
	end

	if(isempty(L)) % if L is empty, output solution
		sol = '';
		XX = sort(X);
		for i=1:length(X)
			sol = strcat(sol, sprintf(' %d', XX(i)));
		end
		disp(sprintf('%s Solution found:%s', indent, sol));
    else
		y = max(L);         % y is the maximum element in L
		dy = abs(y - X);	% dy is delta(y, X)
		z = width - y;      % z is the mirror element of y
		dz = abs(z - X);    % dz is delta(width-y, X)
        
        str = strcat(indent,' try');
        
		if all_in(dy, L) % test if delta(y,X) in L
            
            if(iftrace)
                disp(strcat(str, '   y=', num2str(y)));
            end
            
			X = [X y];
            L = remove(dy, L);
            PLACE(L, X, width,level+1, iftrace);
            X = remove(y, X);
            L = [L dy];
        else
            if(iftrace)
                disp(strcat(str, '   y=', num2str(y),' FAILS'));
            end
        end
        
		if all_in(dz, L) %test if delta(width-y, X) in L
            
            if(iftrace)
                disp(strcat(str, '   w-y=', num2str(z)));
            end
            
            X = [X z];
            L = remove(dz, L);
            PLACE(L, X, width,level+1, iftrace);      
            X = remove(z, X);
            L = [L dz];	
        else
            if(iftrace)
                disp(strcat(str, '   w-y=', num2str(z),' FAILS'));
            end
		end
    end
end

function ret = all_in( arr1, arr2 )
% Input: A, B -- arrays
% Output: ret -- 1 if all element in A is in B, 0 otherwise
% Example: r = all_in([1 1 2], [1 2 3]) --> 0

for i = 1:length(arr1)
    if(ismember(arr1(i),arr2))
        ind = find(arr2 == arr1(i));
        arr2(ind(1)) = [];
        ret = 1;
    else
        ret = 0;
        break;
    end    
end


end

function arr_output = remove( arr1, arr2 )
% remove every element of A from B, ALSO, DO NOT CHANGE B after function call!
% Input: A, B
% Output: ret
% Example: r = remove([1,1], [1,2,1,2]) --> [2 2] 

for i = 1:length(arr1)
    for j = 1:length(arr2)
        if(arr1(i) == arr2(j))
            arr2(j) = [];
            break;
        end            
    end
end

arr_output = arr2;

end


