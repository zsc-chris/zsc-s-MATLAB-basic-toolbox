function ret=isvector(self)
%ISVECTOR	True if input DNT is a vector
%	ret=ISVECTOR(self) returns logical 1 (true) if ndims(V)==1, and logical
%	0 (false) otherwise.
%
%	See also isvector, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=ndims(self)==1;
end