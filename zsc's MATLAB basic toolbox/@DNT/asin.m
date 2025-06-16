function ret=asin(self)
%ASIN	Inverse sine of DNT, result in radians
%	ret=ASIN(self)
%
%	See also asin, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@asin,self);
end