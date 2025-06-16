function ret=abs(self)
%ABS	Absolute value of DNT
%	ret=ABS(self)
%
%	See also abs, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@abs,self);
end