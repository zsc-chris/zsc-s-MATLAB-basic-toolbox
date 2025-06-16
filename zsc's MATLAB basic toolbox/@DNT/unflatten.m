function [ret,dims]=unflatten(self,dim,sz,dims)
%UNFLATTEN	Unflatten DNT
%	[ret,dims]=UNFLATTEN(self,dim=find(contains(self.dimnames,"×"),1),
%	sz=[],dims=[]) returns the unflattened array, with dim unflattened to
%	dims.
%
%	Example:
%	>> UNFLATTEN(DNT(1:4,"a×b"),"a×b",[2,2,1],["a","b","c"])
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    3
%	    2              2    4
%
%	See also DNT, DNT/flatten

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dim(1,:){mustBeA(dim,["logical","numeric","string","char","cell","missing"])}=find(contains(self.dimnames,"×"),1)
		sz(1,:)double=[]
		dims(1,:)string=[]
	end
	arguments(Output)
		ret DNT
		dims(1,:)string
	end
	constructor=str2func(class(self));
	dim=parsedims(self.dimnames,dim);
	zsc.assert(isscalar(dim),"ZSC:DNT:multipleDimensions","One and only one dimension may be unflattened at a time.")
	if isempty(sz)
		sz=resize(size(self,dim),ifinline(ismissing(dim),@()0,@()count(dim,regexpPattern("(?<!×)×(?!×)"))+1),FillValue=1);
	end
	if isempty(dims)
		dims=DNT.splitdim(dim,numel(sz));
	end
	other_dims=setdiff(self.dimnames,dim);
	ret=constructor(reshape(permute(self,[other_dims,dim]),paddata([size(self,other_dims),sz],2,FillValue=1)),[other_dims,dims]);
end