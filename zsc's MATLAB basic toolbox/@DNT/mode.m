function [ret,F,C]=mode(self,dims)
%MODE	Mode, or most frequent value in a sample
%	[ret,F,C]=MODE(self,dims=self.dimnames) reduces self along dims by
%	@MODE.
%
%	Example:
%	>> [ret,F,C]=MODE(DNT([1,2;3,4],["a","b"]),"a")
%
%	ret =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1
%	    2              2
%
%
%	F =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1
%	    2              1
%
%
%	C =
%
%	  2 DNT cell vector
%
%
%	    b
%
%	    1              {2 DNT}
%	    2              {2 DNT}
%
%	>> C{:}
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              3
%
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              4
%
%	>> [ret,F,C]=MODE(DNT([1,2;3,4],["a","b"]),"b")
%
%	ret =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              3
%
%
%	F =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              1
%
%
%	C =
%
%	  2 DNT cell vector
%
%
%	    a
%
%	    1              {2 DNT}
%	    2              {2 DNT}
%
%	>> C{:}
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1
%	    2              2
%
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              3
%	    2              4
%
%	>> [ret,F,C]=MODE(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ret =
%
%	  DNT double scalar
%
%	     1
%
%
%	F =
%
%	  DNT double scalar
%
%	     1
%
%
%	C =
%
%	  DNT cell scalar
%
%	    {4 DNT}
%
%	>> C{:}
%
%	ans =
%
%	  4 DNT double vector
%
%
%	    a×b
%
%	      1                  1
%	      2                  2
%	      3                  3
%	      4                  4
%
%	>> [ret,F,C]=MODE(DNT([1,2;3,4],["a","b"]),[])
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	F =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%
%
%	C =
%
%	  2×2 DNT cell matrix
%
%	         b                    1               2
%	    a
%
%	    1              {scalar DNT}    {scalar DNT}
%	    2              {scalar DNT}    {scalar DNT}
%
%	>> C{:}
%
%	ans =
%
%	  DNT double scalar
%
%	     1
%
%
%	ans =
%
%	  DNT double scalar
%
%	     3
%
%
%	ans =
%
%	  DNT double scalar
%
%	     2
%
%
%	ans =
%
%	  DNT double scalar
%
%	     4
%
%	See also mode, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
		F DNT
		C DNT
	end
	constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	[ret,F,C]=fevalalong(@mode,dims,self);
	C=cellfun(@(x)constructor(x,DNT.catdims(dims)),C,UniformOutput=false);
end