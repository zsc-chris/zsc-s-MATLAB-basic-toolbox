function ret=sinh(self)
%SINH	Hyperbolic sine of DNT
%	ret=SINH(self)
%
%	See also sinh, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sinh,self);
end