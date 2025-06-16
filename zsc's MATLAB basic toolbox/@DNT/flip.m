function ret=flip(self,dims)
%FLIP	Flip a DNT
%	ret=FLIP(self,dims=self.dimnames) transforms self along dims by @flip.
%
%	Example:
%	>> FLIP(DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    4
%	    2              1    2
%
%	>> FLIP(DNT([1,2;3,4],["a","b"]),"b")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              2    1
%	    2              4    3
%
%	>> FLIP(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              4    3
%	    2              2    1
%
%	>> FLIP(DNT([1,2;3,4],["a","b"]),[])
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%	See also sum, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
	end
	ret=fevalalong(@flip,dims,self,Mode="iterate",KeepDims=true);
end