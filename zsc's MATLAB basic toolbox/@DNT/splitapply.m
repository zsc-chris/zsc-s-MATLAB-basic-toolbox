function DNTs=splitapply(f,varargin)
%SPLITAPPLY	Split data into groups and apply function
%	*DNTs=SPLITAPPLY(f,*DNTs,G) is the same as
%	DNTs=groupsummary(DNTs,G,f)
%
%	See also DNT/groupsummary, splitapply, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		varargin DNT
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	DNTs=varargin(1:end-1);
	G=varargin{end};
	f=zsc.function_handle(f,[],nargout);
	DNTs=groupsummary(DNTs,G,f);
end