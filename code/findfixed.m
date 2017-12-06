function board = findfixed(boardsize, rule)

	FIX_POS = 100 ;
	FIX_NEG = -100 ;

	board = zeros(boardsize) ;
	
	for i = 1:boardsize
		rulelength = find(rule(i,:)==0, 1) ;
		if length(rulelength) > 0
			rulelength = rulelength - 1 ;
		else
			rulelength = length(rule(i,:)) ;
		end

		if rulelength == 0
			board(:,i) = FIX_NEG ;
			continue ;
		end

		blackindex = 1 ;
		line = zeros(boardsize, 1) ;
		subline = zeros(boardsize, 1) ;
		for j = 1:rulelength
			subline(blackindex : blackindex + rule(i,j) - 1) = subline(blackindex : blackindex + rule(i,j) - 1) + 1 ;
			blackindex = blackindex + rule(i,j) + 1 ;
		end

		subline_length = blackindex - 2 ;
		subline = subline(1:subline_length) ;
		for j = 1:boardsize-subline_length+1
			line(j : j + subline_length - 1) = line(j : j + subline_length - 1) + subline(:)  ;
		end

		board(find(line==boardsize-subline_length+1),i) = FIX_POS ;
		board(find(line==0),i) = FIX_NEG ;
	end

	for i = boardsize+1:boardsize*2
		rulelength = find(rule(i,:)==0, 1) ;
		if length(rulelength) > 0
			rulelength = rulelength - 1 ;
		else
			rulelength = length(rule(i,:)) ;
		end

		if rulelength == 0
			board(i-boardsize,:) = FIX_NEG ;
			continue ;
		end

		blackindex = 1 ;
		line = zeros(boardsize, 1) ;
		subline = zeros(boardsize, 1) ;
		for j = 1:rulelength
			subline(blackindex : blackindex + rule(i,j) - 1) = subline(blackindex : blackindex + rule(i,j) - 1) + 1 ;
			blackindex = blackindex + rule(i,j) + 1 ;
		end

		subline_length = blackindex - 2 ;
		subline = subline(1:subline_length) ;
		for j = 1:boardsize-subline_length+1
			line(j : j + subline_length - 1) = line(j : j + subline_length - 1) + subline(:) ;
		end

		board(i-boardsize, find(line==boardsize-subline_length+1)) = FIX_POS ;
		board(i-boardsize, find(line==0)) = FIX_NEG ;
	end
end
