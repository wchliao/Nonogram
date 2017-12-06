function rule = readtcga(boardsize, boardnum)
	rule = zeros(boardnum, boardsize*2, ceil(boardsize/2)+1) ;
	boardcount = 0 ;
	linecount = 0 ;

	fid = fopen('tcga2016-question.txt') ;
	tline = fgets(fid) ;
	while ischar(tline)
		if tline(1) == '$'
			boardcount = boardcount + 1 ;
			linecount = 1 ;
			tline = fgets(fid) ;
			continue ;
		end
		
		numline = str2num(tline) ;
		rule(boardcount,linecount, 1:length(numline)) = numline(:) ;
		linecount = linecount + 1 ;
		tline = fgets(fid) ;
	end
	fclose(fid) ;
end
