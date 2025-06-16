function ret=isscalar(self)
%ISSCALAR	True if input DNT is a scalar
%	ret=ISSCALAR(self) returns logical 1 (true) if ndims(V)==0, and logical
%	0 (false) otherwise.
%
%	See also isscalar, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=ndims(self)==0;
end