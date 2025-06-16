function ret=isfloat(self)
%ISFLOAT	True if DNT's underlying elements are floating-point
%	ret=ISFLOAT(self) returns true if underlyingType(self) is a
%	floating-point data type and false otherwise.
%
%	See also isfloat, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isfloat(gather(self));
end