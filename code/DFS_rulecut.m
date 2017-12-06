function solution = DFS_rulecut(boardsize, rule)
	possible_rows = find_possibles(boardsize, rule(boardsize+1:boardsize*2,:)) ; 
	solution = solveDFS(zeros(boardsize), boardsize, rule, possible_rows, 1) ;
end

function [solution, solved] = solveDFS(board, boardsize, rule, possible_rows, row)
	if row > boardsize
		solution = board ;
		solved = checkboard(board, boardsize, rule) ;
		return
	end

	for i = 1:size(possible_rows{row}, 1)
		board(row,:) = possible_rows{row}(i,:) ;
		for col = 1:boardsize
			if ~checkline(board(1:row,col), rule(col,:))
				solution = board ;
				solved = false ;
				break ;
			end
			[solution, solved] = solveDFS(board, boardsize, rule, possible_rows, row+1) ;
			if solved
				return
			end
		end	
	end
end
