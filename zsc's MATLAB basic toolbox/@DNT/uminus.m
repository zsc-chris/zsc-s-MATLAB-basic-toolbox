function ret=uminus(self)
%-	Unary minus for DNT
%	ret=-self
%	ret=UMINUS(self)
%
%	See also uminus, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@uminus,self);
end