function board = normalboard(board)
	board(board > 0) = 1 ;
	board(board < 0) = 0 ;
end
