function ret=prod(self,dims,nanflag)
%PROD	Product of elements of DNT
%	ret=PROD(self,dims=self.dimnames,nanflag="includemissing") reduces self
%	along dims by @PROD.
%
%	Example:
%	>> PROD(DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              3
%	    2              8
%
%	>> PROD(DNT([1,2;3,4],["a","b"]),"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1               2
%	    2              12
%
%	>> PROD(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  DNT double scalar
%
%	    24
%
%	>> PROD(DNT([1,2;3,4],["a","b"]),[])
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
%	See also prod, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret DNT
	end
	ret=fevalalong(@prod,dims,self,Mode="flatten",AdditionalInput={nanflag});
end