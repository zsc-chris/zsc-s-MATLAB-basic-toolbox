function ret=ismatrix(self)
%ISMATRIX	True if input DNT is a matrix
%	ret=ISMATRIX(self) returns logical 1 (true) if ndims(V)==2, and logical
%	0 (false) otherwise.
%
%	See also ismatrix, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=ndims(self)==2;
end