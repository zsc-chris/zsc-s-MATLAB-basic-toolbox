function [ret,dim,sz]=flatten(self,dims,dim)
%FLATTEN	Flatten DNT
%	[ret,dim,sz]=FLATTEN(self,dims=self.dimnames,dim=string(missing))
%	returns the flattened array, with dims flattened into dim, and the size
%	of the original dimension for later recovery of the flattened
%	dimensions using unflatten.
%
%	Example:
%	>> FLATTEN(DNT([1,3;2,4],["a","b"]),["a","b","c"])
%
%	ans =
%
%	  4 DNT double vector
%
%
%	    a×b×c
%
%	        1                      1
%	        2                      2
%	        3                      3
%	        4                      4
%
%	See also DNT, DNT/unflatten

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		dim(1,1)string=missing
	end
	arguments(Output)
		ret DNT
		dim(1,1)string
		sz(1,:)double{mustBeInteger,mustBeNonnegative}
	end
	constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	if ismissing(dim)
		dim=DNT.catdims(dims);
	end
	other_dims=setdiff(self.dimnames,dims);
	sz=size(self,dims);
	ret=constructor(flatten(gather(self),DNT.index(self.dimnames,dims)),[dim,other_dims]);
end