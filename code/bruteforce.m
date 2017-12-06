function solution = bruteforce(boardsize, rule)
	solution = solveBF(zeros(boardsize), boardsize, rule, 1) ;
end

function [solution, solved] = solveBF(board, boardsize, rule, index)
	if index > boardsize^2
		solution = board ;
		solved = checkboard(board, boardsize, rule) ;
		return
	end
	
	board(index) = 0 ;
	[solution, solved] = solveBF(board, boardsize, rule, index+1) ;
	if solved
		return
	end

	board(index) = 1 ;
	[solution, solved] = solveBF(board, boardsize, rule, index+1) ;
end

