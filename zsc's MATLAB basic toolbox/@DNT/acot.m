function ret=acot(self)
%ACOT	Inverse cotangent of DNT, result in radians
%	ret=ACOT(self)
%
%	See also acot, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@acot,self);
end