function ret=num2cell(self,dims)
%num2cell	Convert numeric array to cell array
%	ret=num2cell(self,dims=[]) converts self to cell array preserving dims.
%
%	Examples
%	>> num2cell(DNT([1,2;3,4],["a","b"]))
%
%	ans =
%
%	  2×2 DNT cell matrix
%
%	         b                    1               2
%	    a
%
%	    1              {scalar DNT}    {scalar DNT}
%	    2              {scalar DNT}    {scalar DNT}
%
%	>> ans{:}
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
%	>> num2cell(DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT cell vector
%
%
%	    b
%
%	    1              {2 DNT}
%	    2              {2 DNT}
%
%	>> ans{:}
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
%	>> num2cell(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  DNT cell scalar
%
%	    {2×2 DNT}
%
%	>> ans{:}
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
%	See also num2cell, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=[]
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	self.dimnames=[self.dimnames,setdiff(dims,self.dimnames)];
	[dimsin,dimsout]=deal(self.dimnames);
	dimsin(~ismember(dimsin,dims))=missing;
	dimsout(ismember(dimsin,dims))=missing;
	ret=constructor(zsc.num2cell(gather(self),DNT.index(self.dimnames,dims)),dimsout);
	ret=cellfun(@(x)constructor(x,dimsin),ret,UniformOutput=false);
end