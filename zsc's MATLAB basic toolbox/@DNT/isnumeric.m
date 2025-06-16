function ret=isnumeric(self)
%ISNUMERIC	True if DNT's underlying elements are numeric
%	ret=ISNUMERIC(self) returns true if underlyingType(self) is a built-in
%	numeric type and false otherwise.
%
%	See also isnumeric, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isnumeric(gather(self));
end