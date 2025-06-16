function ret=isinteger(self)
%ISINTEGER	True if DNT's underlying elements are integer
%	ret=ISINTEGER(self) returns true if underlyingType(self) is an integer
%	data type and false otherwise.
%
%	See also isinteger, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isinteger(gather(self));
end