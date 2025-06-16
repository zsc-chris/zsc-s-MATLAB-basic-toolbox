function [ret,M]=var(self,w,dims,nanflag)
%VAR	Variance
%	ret=VAR(self,w=[],dims=self.dimnames,nanflag="includemissing") reduces
%	self (and w if w is other than [], 0 and 1) along dims by @VAR.
%
%	Example:
%	>> VAR(DNT([1,2;3,nan],["a","b"]),1,"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1                1
%	    2              NaN
%
%	>> VAR(DNT([1,2;3,nan],["a","b"]),DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              0.7500
%	    2                 NaN
%
%	See also var, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		w{mustBeNumeric}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret DNT
		M DNT
	end
	if isequal(w,[])
		w=0;
	end
	if ~isa(w,"DNT")&&isscalar(w)&&ismember(w,[0,1])
		[ret,M]=fevalalong(@(x,dims,nanflag)zsc.var(x,w,dims,nanflag),dims,self,AdditionalInput={nanflag});
	else
		[ret,M]=fevalalong(@var,dims,self,w,Mode="flatten",BroadcastSizeDims="all",AdditionalInput={nanflag},Vectorized=false);
	end
end