function dimnames=gennewdims(dims)
%DNT.gennewdims	Generates new dimension names
%	dimnames=DNT.gennewdims(dims)
%
%	Example:
%	>> DNT.gennewdims(2:3)
%
%	ans =
%
%	  1×2 string array
%
%	    "x'"    "x''"
%
%	See also DNT.catdims, DNT.splitdim, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		dims(1,:)double{mustBeInteger,mustBePositive}=double.empty(1,0)
	end
	dimnames="x"+arrayfun(@(x)string(repmat('''',[1,x-1])),dims);
end