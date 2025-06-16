function dimname=catdims(dimnames)
%DNT.catdims	Concatenate dimension names
%	dimname=DNT.catdims(dimnames)
%
%	Example:
%	>> DNT.catdims(["a","b"])
%
%	ans =
%
%	    "a×b"
%
%	>> DNT.catdims([])
%
%	ans =
%
%	    <missing>
%
%	See also DNT.gennewdims, DNT.splitdim, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		dimnames(1,:)string
	end
	arguments(Output)
		dimname(1,1)string
	end
	dimname=join(dimnames,"×");
end