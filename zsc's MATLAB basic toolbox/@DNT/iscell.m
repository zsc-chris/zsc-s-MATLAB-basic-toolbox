function ret=iscell(self)
%ISCELL	True if DNT's underlying elements are cell
%	ret=ISCELL(self) returns true if underlyingType(self) is a cell type
%	and false otherwise.
%
%	See also iscell, underlyingType, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=iscell(gather(self));
end