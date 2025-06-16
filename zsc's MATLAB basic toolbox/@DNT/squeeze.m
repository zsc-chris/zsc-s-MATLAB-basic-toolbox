function ret=squeeze(self,dims)
%SQUEEZE	Remove singleton dimensions
%	ret=SQUEEZE(self,dims=find(size(self)==1)) returns a DNT ret with the
%	same elements as self but with all the singleton dimensions dims
%	removed. A singleton is a dimension such that size(A,dim)==1.
%
%	Example:
%	>> zeros([2,2,2],["a","b","c"],"DNT")
%
%	  2×2×2 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%
%	>> ans(a=':',b=':',c=1).squeeze(3)
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%
%	See also squeeze, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=find(size(self)==1)
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	dims=DNT.index(self.dimnames,dims);
	ind=setdiff(1:ndims(self),dims);
	ret=constructor(zsc.squeeze(gather(self),dims),self.dimnames(ind));
end