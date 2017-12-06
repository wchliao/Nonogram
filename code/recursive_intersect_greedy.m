function solution = recursive_intersect_greedy(boardsize, rule)
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
			nextIndex_prob = zeros(boardsize) ;
			for i = 1:boardsize
				if length(find(nextIndex_prob(:,i)==0)) == 0
					continue ;
				end
				nextIndex_prob(:,i) = nextIndex_prob(:,i) + (sum(possible_cols{i},1) / size(possible_cols{i},1))' ;
			end
			for i = 1:boardsize
				if length(find(nextIndex_prob(i,:)==0)) == 0
					continue ;
				end
				nextIndex_prob(i,:) = nextIndex_prob(i,:) + sum(possible_rows{i},1) / size(possible_rows{i},1) ;
			end
			nextIndex_prob = nextIndex_prob/2 ;

			possible_nextIndex = find(board==0) ;
			[maxValue maxIndex] = max(nextIndex_prob(possible_nextIndex)) ;
			[minValue minIndex] = min(nextIndex_prob(possible_nextIndex)) ;
			if 1 - maxValue < minValue
				nextIndex = possible_nextIndex(maxIndex) ;
				board(nextIndex) = FIX_POS ;
			else
				nextIndex = possible_nextIndex(minIndex) ;
				board(nextIndex) = FIX_NEG ;
			end

			[solution solved] = solveboard(board, boardsize, possible_rows, possible_cols, rule) ;
			if solved
				return
			end

			if board(nextIndex) == FIX_POS
				board(nextIndex) = FIX_NEG ;
			else
				board(nextIndex) = FIX_POS ;
			end
			[solution solved] = solveboard(board, boardsize, possible_rows, possible_cols, rule) ;
			return
		end
	end

	solution = board ;
	solved = checkboard(solution, boardsize, rule) ;
end

