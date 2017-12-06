function possible_rows = prune_possible_rows(possible_rows, board, boardsize)
	FIX_POS = 100 ;
	FIX_NEG = -100 ;
	for i = 1:boardsize
		remove_rows = [] ;
		for j = 1:size(possible_rows{i},1)
			posIndex = find(board(i,:) == FIX_POS) ; 
			if sum(possible_rows{i}(j, posIndex)) ~= length(posIndex)
				remove_rows = [remove_rows j] ; 
				continue ;
			end
			negIndex = find(board(i,:) == FIX_NEG) ; 
			if sum(possible_rows{i}(j, negIndex)) ~= 0
				remove_rows = [remove_rows j] ; 
				continue ;
			end
		end
		possible_rows{i}(remove_rows,:) = [] ;
	end
end


