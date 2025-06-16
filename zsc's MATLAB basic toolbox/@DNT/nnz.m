function ret=nnz(self,dims)
%NNZ	Number of nonzero DNT elements
%	ret=NNZ(self,dims=self.dimnames) reduces self along dims by @NNZ.
%
%	Example:
%	>> NNZ(DNT([1,0;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              2
%	    2              1
%
%	>> NNZ(DNT([1,0;3,4],["a","b"]),"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              2
%
%	>> NNZ(DNT([1,0;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  DNT double scalar
%
%	     3
%
%	>> NNZ(DNT([1,0;3,4],["a","b"]),[])
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    0
%	    2              1    1
%
%	See also nnz, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
	end
	self=self~=0;
	ret=fevalalong(@sum,dims,self);
end