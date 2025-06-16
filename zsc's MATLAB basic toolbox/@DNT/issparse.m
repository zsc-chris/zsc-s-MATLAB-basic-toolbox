function ret=issparse(self)
%ISSPARSE	True for sparse DNT matrix
%	ret=ISSPARSE(self)
%
%	See also issparse, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=issparse(gather(self));
end