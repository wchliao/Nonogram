function solution = DFS_possiblecut_wiki(boardsize, rule)
	
	fixedboard = findfixed(boardsize, rule) ;  
	possible_rows = find_possibles(boardsize, rule(boardsize+1:boardsize*2,:)) ;
	possible_cols = find_possibles(boardsize, rule(1:boardsize,:)) ;
	possible_rows = prune_possible_rows(possible_rows, fixedboard, boardsize) ;
	solution = solveDFS(zeros(boardsize), boardsize, rule, possible_rows, possible_cols, 1) ;
end

function [solution, solved] = solveDFS(board, boardsize, rule, possible_rows, possible_cols, row)
	possible_cols = prune_possible_cols(possible_cols, board, boardsize, row) ;

	if row > boardsize
		solution = board ;
		solved = checkboard(board, boardsize, rule) ;
		return
	end

	for i = 1:size(possible_rows{row}, 1)
		board(row,:) = possible_rows{row}(i,:) ;
		[solution, solved] = solveDFS(board, boardsize, rule, possible_rows, possible_cols, row+1) ;
		if solved
			return
		end
	end
end

function possible_cols = prune_possible_cols(possible_cols, board, boardsize, row)
	if row < boardsize
		board(row+1:end,:) = -1 ;
	end
	FIX_POS = 1 ;
	FIX_NEG = 0 ;
	for i = 1:boardsize
		remove_cols = [] ;
		for j = 1:size(possible_cols{i},1)
			posIndex = find(board(:,i) == FIX_POS) ;
			if sum(possible_cols{i}(j, posIndex)) ~= length(posIndex)
				remove_cols = [remove_cols j] ;
				continue ;
			end
			negIndex = find(board(:,i) == FIX_NEG) ;
			if sum(possible_cols{i}(j, negIndex)) ~= 0
				remove_cols = [remove_cols j] ;
				continue ;
			end
		end
		possible_cols{i}(remove_cols,:) = [] ;
	end
end

