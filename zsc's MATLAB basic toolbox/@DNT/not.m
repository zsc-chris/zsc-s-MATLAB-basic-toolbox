function ret=not(self)
%~	Logical NOT for DNT
%	ret=~self
%	ret=NOT(self)
%
%	See also not, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@not,self);
end