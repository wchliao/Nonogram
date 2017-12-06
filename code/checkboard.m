function solved = checkboard(board, boardsize, rule)

	board = normalboard(board) ;

	for i = 1:boardsize
		rulelength = find(rule(i,:)==0, 1) ;
		if length(rulelength) > 0
			rulelength = rulelength - 1 ;
		else
			rulelength = length(rule(i,:)) ;
		end
		blackindex = find(board(:,i)) ;

		if rulelength == 0 || length(blackindex) == 0
			if rulelength == 0 && length(blackindex) == 0
				continue
			else
				solved = false ;
				return
			end
		end
		if length(blackindex) == 1 
			if rulelength ~= 1 || rule(i,1) ~= 1
				solved = false ;
				return
			else
				continue
			end
		end

		blocksize = 1 ;
		ruleCount = 1 ;
		for j = 2:length(blackindex)
			if ruleCount > rulelength
				solved = false ;
				return
			end

			if blackindex(j) == blackindex(j-1) + 1
				blocksize = blocksize + 1 ;
				if blocksize > rule(i, ruleCount)
					solved = false ;
					return
				end
			elseif blocksize ~= rule(i, ruleCount)
				solved = false ;
				return
			else
				blocksize = 1 ;
				ruleCount = ruleCount + 1 ;
			end
		end
		if ruleCount ~= rulelength
			solved = false ;
			return
		end
		if blocksize ~= rule(i, ruleCount)
			solved = false ;
			return
		end
	end

	for i = boardsize+1 : boardsize*2
		rulelength = find(rule(i,:)==0, 1) ;
		if length(rulelength) > 0
			rulelength = rulelength - 1 ;
		else
			rulelength = length(rule(i,:)) ;
		end
		blackindex = find(board(i-boardsize,:)) ;

		if rulelength == 0 || length(blackindex) == 0
			if rulelength == 0 && length(blackindex) == 0
				continue
			else
				solved = false ;
				return
			end
		end
		if length(blackindex) == 1 
			if rulelength ~= 1 || rule(i,1) ~= 1
				solved = false ;
				return
			else
				continue
			end
		end

		blocksize = 1 ;
		ruleCount = 1 ;
		for j = 2:length(blackindex)
			if ruleCount > rulelength
				solved = false ;
				return
			end

			if blackindex(j) == blackindex(j-1) + 1
				blocksize = blocksize + 1 ;
				if blocksize > rule(i, ruleCount)
					solved = false ;
					return
				end
			elseif blocksize ~= rule(i, ruleCount)
				solved = false ;
				return
			else
				blocksize = 1 ;
				ruleCount = ruleCount + 1 ;
			end
		end
		if ruleCount ~= rulelength
			solved = false ;
			return
		end
		if blocksize ~= rule(i, ruleCount)
			solved = false ;
			return
		end
	end

	solved = true ;
end
