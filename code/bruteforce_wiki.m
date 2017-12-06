function solution = bruteforce_rulecut_wiki(boardsize, rule)
	fixedboard = findfixed(boardsize, rule) ; 
	solution = solveBF(fixedboard, boardsize, rule, 1) ;
	solution = normalboard(solution) ;
end

function [solution, solved] = solveBF(board, boardsize, rule, index)
	if index > boardsize^2
		solution = board ;
		solved = checkboard(board, boardsize, rule) ;
		return
	end

	nextIndex = index + 1 ;
	while nextIndex <= boardsize^2 && (board(nextIndex) > 1 || board(nextIndex) < 0)
		nextIndex = nextIndex + 1 ;
	end

	board(index) = 0 ;
	[solution, solved] = solveBF(board, boardsize, rule, nextIndex) ;
	if solved
		return
	end

	board(index) = 1 ;
	[solution, solved] = solveBF(board, boardsize, rule, nextIndex) ;
	if solved
		return
	end
end
