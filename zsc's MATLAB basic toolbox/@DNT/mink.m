function [ret,I]=mink(self,k,dims,options)
%MINK	Find K smallest elements of DNT
%	[ret,I]=MINK(self,k,dims=self.dimnames,*,ComparisonMethod="auto")
%	transforms self along dims by @MINK.
%
%	Note: A new dimension will be selected if dims is empty.
%
%	Example:
%	>> MINK(DNT([1,2;3,4],["a","b"]),1,"a")
%
%	ans =
%
%	  1×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%
%	>> MINK(DNT([1,2;3,4],["a","b"]),2,["a","b"])
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a×b
%
%	      1                  1
%	      2                  2
%
%	>> MINK(DNT([1,2;3,4],["a","b"]),2,[])
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',x''=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%	>> MINK(DNT([1,2;3,4],["a","b"]),2,"c")
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%	See also mink, DNT
%
%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		k(1,1)double{mustBeInteger,mustBeNonnegative}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret DNT
		I DNT
	end
	dstar=dstarclass;
	[ret,I]=fevalalong(@(x,dim,varargin)mink(x,k,dim,varargin{:}),dims,self,KeepDims=true,Mode="flatten",AdditionalInput={dstar{options}});
end