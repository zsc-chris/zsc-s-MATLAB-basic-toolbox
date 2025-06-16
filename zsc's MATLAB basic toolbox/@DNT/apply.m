function DNTs=apply(self,f,options)
%APPLY	Eval a function on a DNT
%	*DNTs=APPLY(self,f,**options) is the same as
%	*DNTs=feval(self,f,**options).
%
%	See also DNT/feval

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		self DNT
		f(1,1)function_handle
		options.AdditionalInput(1,:)cell
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	dstar=dstarclass;
	[DNTs{1:nargout}]=feval(f,self,dstar{options});
end