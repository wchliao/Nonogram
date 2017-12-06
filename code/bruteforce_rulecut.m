function solution = bruteforce_rulecut(boardsize, rule)
	solution = solveBF(zeros(boardsize), boardsize, rule, 1) ;
end

function [solution, solved] = solveBF(board, boardsize, rule, index)
	if index > boardsize^2
		solution = board ;
		solved = checkboard(board, boardsize, rule) ;
		return
	end

	board(index) = 0 ;
	[row col] = ind2sub([boardsize, boardsize], index) ;
	if checkline(board(1:row,col), rule(col,:)) && checkline(board(row,1:col), rule(boardsize+row,:))
		[solution, solved] = solveBF(board, boardsize, rule, index+1) ;
		if solved
			return
		end
	end

	board(index) = 1 ;
	if checkline(board(1:row,col), rule(col,:)) && checkline(board(row,1:col), rule(boardsize+row,:))
		[solution, solved] = solveBF(board, boardsize, rule, index+1) ;
		if solved
			return
		end
	end
	solution = board ;
	solved = false ;
end
