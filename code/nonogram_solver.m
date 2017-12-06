function nonogram_solver(boardsize, boardnum, methodnum)
	
	method = {
	@bruteforce, ...			% 1 : brute force (each time put a possible pixel in the board and then find the next possible pixel)
	@bruteforce_rulecut, ...		% 2 : brute force + cut by rule checking
	@bruteforce_wiki, ...			% 3 : brute force + techniques from Wiki
	@bruteforce_rulecut_wiki, ...		% 4 : brute force + cut by rule checking + techniques from Wiki
	@DFS, ...				% 5 : DFS (each time put a possible row in the board and find for the next possible row)
	@DFS_rulecut, ...			% 6 : DFS + cut by rule checking
	@DFS_wiki, ...				% 7 : DFS + techniques from Wiki
	@DFS_rulecut_wiki, ...			% 8 : DFS + cut by rule checking + techniques from Wiki
	@DFS_possiblecut, ...			% 9 : DFS + cut state space
	@DFS_possiblecut_wiki, ...		% 10: DFS + cut state space + techniques from Wiki
	@recursive_intersect, ...		% 11: Intersection method
	@recursive_intersect_greedy, ...	% 12: Intersection method + greedy step when convergence
	} ;	
	
	if ischar(methodnum)
		methodnum = find( strcmp(cellfun(@func2str,method,'UniformOutput',false), methodnum) ) ; 
	end

	fid = fopen('solution.txt','w')  ;
	rule = readtcga(boardsize, boardnum) ;
	
	for b = 1:boardnum
		fprintf(fid,'$%d\n', b) ;
		fprintf('Game %2d: ', b) ;
		tic ;
		solution = method{methodnum}(boardsize, squeeze(rule(b,:,:))) ;
		toc ;
		
		if checkboard(solution, boardsize, squeeze(rule(b,:,:))) 
			fprintf('         The solution is correct.\n') ;
		else
			fprintf('         The solution is not correct.\n') ;
		end

		for i = 1:boardsize
			for j = 1:boardsize-1
				fprintf(fid, '%d\t', solution(i,j)) ;
			end
			fprintf(fid, '%d\n', solution(i,boardsize)) ;
		end
	end

	fclose(fid) ;
end
