function ret=median(self,dims,nanflag,options)
%MEDIAN	Median value
%	ret=MEDIAN(self,dims=self.dimnames,nanflag="includemissing",*,
%	Weights=Weights) reduces self along dims by @MEDIAN. If weights is
%	specified, self and Weights will be broadcast against each other.
%
%	Example:
%	>> MEDIAN(DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              2
%	    2              3
%
%	>> MEDIAN(DNT([1,2;3,4],["a","b"]),"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1.5000
%	    2              3.5000
%
%	>> MEDIAN(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  DNT double scalar
%
%	    2.5000
%
%	>> MEDIAN(DNT([1,2;3,4],["a","b"]),[])
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
%	>> MEDIAN(DNT([1,2;3,4],["a","b"]),Weights=DNT([.25;.75],"a"))
%
%	ans =
%
%	  DNT double scalar
%
%	     3
%
%	See also median, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
		options.Weights DNT
	end
	arguments(Output)
		ret DNT
	end
	if isfield(options,"Weights")
		ret=fevalalong(@(x,w,dims)median(x,dims,nanflag,Weights=w),dims,self,options.Weights,Mode="flatten",BroadcastSizeDims="all");
	else
		ret=fevalalong(@median,dims,self,AdditionalInput={nanflag});
	end
end