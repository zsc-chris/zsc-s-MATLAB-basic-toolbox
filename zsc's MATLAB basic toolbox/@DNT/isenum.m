function ret=isenum(self)
%ISCHAR	True if DNT's underlying elements are enumeration
%	ret=ISCHAR(self) returns true if underlyingType(self) is an enumeration
%	type and false otherwise.
%
%	See also isenum, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isenum(gather(self));
end