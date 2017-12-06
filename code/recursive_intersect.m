function solution = recursive_intersect(boardsize, rule)
	possible_cols = find_possibles(boardsize, rule(1:boardsize,:)) ;
	possible_rows = find_possibles(boardsize, rule(boardsize+1:boardsize*2,:)) ;

	solution = solveboard(zeros(boardsize), boardsize, possible_rows, possible_cols, rule) ;
	solution = normalboard(solution) ; 
end

function [solution solved] = solveboard(board, boardsize, possible_rows, possible_cols, rule)
	FIX_POS = 100 ;
	FIX_NEG = -100 ;
	
	possible_rows = prune_possible_rows(possible_rows, board, boardsize) ;
	possible_cols = prune_possible_cols(possible_cols, board, boardsize) ;
	
	while length(find(board==0)) 
		originboard = board ;
		for i = 1:boardsize
			if length(find(board(:,i)==0)) == 0
				continue ;
			end

			board(find(sum(possible_cols{i},1) == size(possible_cols{i},1)), i) = FIX_POS ;
			board(find(sum(possible_cols{i},1) == 0), i) = FIX_NEG ;
		end
		possible_rows = prune_possible_rows(possible_rows, board, boardsize) ;
		
		for i = 1:boardsize
			if length(find(board(i,:)==0)) == 0
				continue ;
			end

			board(i, find(sum(possible_rows{i},1) == size(possible_rows{i},1))) = FIX_POS ;
			board(i, find(sum(possible_rows{i},1) == 0)) = FIX_NEG ;
		end
		possible_cols = prune_possible_cols(possible_cols, board, boardsize) ;

		if originboard == board
			nextIndex = find(board==0,1) ;
			board(nextIndex) = FIX_POS ;
			[solution solved] = solveboard(board, boardsize, possible_rows, possible_cols, rule) ;
			if solved
				return
			end
			board(nextIndex) = FIX_NEG ;
			[solution solved] = solveboard(board, boardsize, possible_rows, possible_cols, rule) ;
			return
		end
	end

	solution = board ;
	solved = checkboard(solution, boardsize, rule) ;
end


