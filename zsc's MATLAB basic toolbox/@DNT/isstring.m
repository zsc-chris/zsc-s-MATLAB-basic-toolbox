function ret=isstring(self)
%ISSTRING	True if DNT's underlying elements are string
%	ret=ISSTRING(self) returns true if underlyingType(self) is a string
%	type and false otherwise.
%
%	See also isstring, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isstring(gather(self));
end