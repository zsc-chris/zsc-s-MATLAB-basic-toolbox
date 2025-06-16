function ret=isstruct(self)
%ISSTRUCT	True if DNT's underlying elements are struct
%	ret=ISSTRUCT(self) returns true if underlyingType(self) is a struct
%	type and false otherwise.
%
%	See also isstruct, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isstruct(gather(self));
end