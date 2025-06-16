function ret=underlyingType(self)
%underlyingType	Name of underlying data type determining DNT behavior
%	ret=underlyingType(self)
%
%	See also isUnderlyingType, mustBeUnderlyingType, class, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret(1,:)char
	end
	ret=underlyingType(gather(self));
end