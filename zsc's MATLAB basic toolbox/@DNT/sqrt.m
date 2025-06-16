function ret=sqrt(self)
%SQRT	Square root of DNT
%	ret=SQRT(self)
%
%	See also sqrt, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sqrt,self);
end