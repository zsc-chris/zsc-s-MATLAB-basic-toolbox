function DNTs=cellfun(f,DNTs,options)
%CELLFUN	Apply a function to each cell content of DNTs
%	*DNTs=CELLFUN(f,*DNTs,UniformOutput=true)
%
%	See also cellfun, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Input)
		options.UniformOutput(1,1)logical=true
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	dstar=dstarclass;
	[tmp{1:nargout}]=feval(@(varargin)cellfun(f,varargin{:}),DNTs{:},AdditionalInput={dstar{options}});
	DNTs=tmp;
end