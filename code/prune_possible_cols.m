function possible_cols = prune_possible_cols(possible_cols, board, boardsize)
	FIX_POS = 100 ;
	FIX_NEG = -100 ;
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

