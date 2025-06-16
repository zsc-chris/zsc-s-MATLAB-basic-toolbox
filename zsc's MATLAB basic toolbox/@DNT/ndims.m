function ret=ndims(self)
%NDIMS	Number of dimensions of DNT
%	ret=NDIMS(self)
%
%	Note: NDIMS<2 is possible.
%
%	Example:
%	>> NDIMS(DNT(1))
%
%	ans =
%
%	     0
%
%	>> NDIMS(DNT(1,"a"))
%
%	ans =
%
%	     1
%
%	>> NDIMS(DNT(1,["a","b"]))
%
%	ans =
%
%	     2
%
%	>> NDIMS(DNT(1,["a","b","c"]))
%
%	ans =
%
%	     3
%
%	See also ndims, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret(1,1)double{mustBeInteger,mustBeNonnegative}
	end
	ret=numel(self.dimnames);
end