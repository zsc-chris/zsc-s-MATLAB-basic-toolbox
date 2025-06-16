function ret=trace(self,dims)
%TRACE	Sum of diagonal elements
%	ret=TRACE(self,dims=self.dimnames)
%
%	Example:
%	>> TRACE(ones([2,3,4],["a","b","c"],"DNT"),["a","c"])
%
%	ans =
%
%	  3 DNT double vector
%
%
%	    b
%
%	    1              2
%	    2              2
%	    3              2
%
%	See also trace, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	dims=parsedims(self.dimnames,dims);
	self.dimnames(DNT.index(self.dimnames,dims))=dims(1);
	ret=sum(self,dims(1));
end