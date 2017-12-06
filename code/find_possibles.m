function possibles = find_possibles(boardsize, rule)

	possibles = initcell(boardsize) ;

	for i = 1:boardsize
		rulelength = find(rule(i,:)==0, 1) ;
		rulelength = rulelength - 1 ;

		possibles{i} = find_possible(boardsize + 1, rule(i, 1:rulelength)) ;
		possibles{i}(:,end) = [] ;
	end
end

function possible = find_possible(n, k)
	possible = [] ;
	
	if length(k) == 0
		possible = zeros(1,n) ;
		return
	end

	if n >= sum(k) + length(k)
		appends = find_possible(n-k(1)-1, k(2:end)) ;
		appends = [ones(size(appends,1), k(1)) zeros(size(appends,1),1) appends] ;
		possible = [possible ; appends ] ;
	end

	if n > sum(k) + length(k) 
		appends = find_possible(n-1, k) ;
		appends = [zeros(size(appends,1), 1) appends] ;
		possible = [possible ; appends] ;
	end
end

function cell = initcell(cellsize)
	for i = 1:cellsize
		cell{i} = [] ;
	end
end
