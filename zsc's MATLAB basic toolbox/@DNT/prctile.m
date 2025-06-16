function ret=prctile(self,p,dims,options)
%PRCTILE	Percentiles of a sample
%	ret=PRCTILE(self,p,dims=self.dimnames,*,Method="exact") transforms self
%	along dims by @PRCTILE.
%
%	Note: A new dimension will be selected if dims is empty.
%
%	Example:
%	>> PRCTILE(DNT([1,2;3,4],["a","b"]),[25,50,75],"a")
%
%	ans =
%
%	  3×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              2    3
%	    3              3    4
%
%	>> PRCTILE(DNT([1,2;3,4],["a","b"]),[25,50,75],[])
%
%	  2×2×3 DNT double tensor
%
%	ans(a=':',b=':',x''=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ans(a=':',b=':',x''=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ans(a=':',b=':',x''=3).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%	>> PRCTILE(DNT([1,2;3,4],["a","b"]),[25,50,75],"c")
%
%	  2×2×3 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ans(a=':',b=':',c=3).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%	See also prctile, DNT
%
%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		p(:,1){mustBeNumericOrLogical}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		options.Method(1,1)string{mustBeMember(options.Method,["exact","approximate"])}="exact"
	end
	dstar=dstarclass;
	ret=fevalalong(@(self,dims,p,varargin)prctile(self,p,dims,varargin{:}),dims,self,Mode="flatten",KeepDims=true,AdditionalInput={p,dstar{options}});
end