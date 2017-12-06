function result = checkline(line, rule)

	line = normalboard(line) ;

	blackindex = find(line) ;

	if length(blackindex) == 0
		result = true ;
		return
	end

	rulelength = find(rule==0, 1) ;
	if length(rulelength) > 0
		rulelength = rulelength - 1 ;
	else
		rulelength = length(rule) ;
	end

	if rulelength == 0 
		result = false ;
		return
	end

	if length(blackindex) == 1 
		if blackindex == length(line) % check if it is the last element
			result = true ;
			return
		elseif rule(1) == 1
			result = true ;
			return
		else
			result = false ;
			return
		end
	end

	blocksize = 1 ;
	ruleCount = 1 ;
	for j = 2:length(blackindex)
		if ruleCount > rulelength
			result = false ;
			return
		end
	
		if blackindex(j) == blackindex(j-1) + 1
			blocksize = blocksize + 1 ;
			if blocksize > rule(ruleCount)
				result = false ;
				return
			end
		elseif blocksize ~= rule(ruleCount)
			result = false ;
			return
		else
			blocksize = 1 ;
			ruleCount = ruleCount + 1 ;
		end
	end

	result = true ;
end

