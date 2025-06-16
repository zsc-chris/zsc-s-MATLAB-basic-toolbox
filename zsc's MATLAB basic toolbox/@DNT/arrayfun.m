function DNTs=arrayfun(f,DNTs,options)
%ARRAYFUN	Apply a function to each element of DNTs
%	*DNTs=ARRAYFUN(f,*DNTs,UniformOutput=true)
%
%	See also arrayfun, DNT

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
	nargout_=max(nargout,abs(nargout(f)));
	dstar=dstarclass;
	[tmp{1:nargout_}]=feval(@(varargin)arrayfun(f,varargin{:}),DNTs{:},AdditionalInput={dstar{options}});
	DNTs=tmp;
end