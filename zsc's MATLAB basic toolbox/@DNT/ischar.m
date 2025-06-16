function ret=ischar(self)
%ISCHAR	True if DNT's underlying elements are char
%	ret=ISCHAR(self) returns true if underlyingType(self) is a char type
%	and false otherwise.
%
%	See also ischar, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=ischar(gather(self));
end