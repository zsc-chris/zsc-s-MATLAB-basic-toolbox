function [ret,M]=std(self,w,dims,missingflag)
%STD	Standard deviation
%	ret=STD(self,w=[],dims=self.dimnames,missingflag="includemissing")
%	reduces self (and w if w is other than [], 0 and 1) along dims by @STD.
%
%	Example:
%	>> STD(DNT([1,2;3,nan],["a","b"]),1,"a")
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
%	>> STD(DNT([1,2;3,nan],["a","b"]),DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              0.8660
%	    2                 NaN
%
%	See also std, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		w{mustBeNumeric}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		missingflag(1,1)string{mustBeMember(missingflag,["includemissing","includenan","includenat","omitmissing","omitnan","omitnat"])}="includemissing"
	end
	arguments(Output)
		ret DNT
		M DNT
	end
	if isequal(w,[])
		w=0;
	end
	if ~isa(w,"DNT")&&isscalar(w)&&ismember(gather(w),[0,1])
		[ret,M]=fevalalong(@(x,dims,missingflag)zsc.std(x,w,dims,missingflag),dims,self,AdditionalInput={missingflag});
	else
		[ret,M]=fevalalong(@std,dims,self,w,Mode="flatten",BroadcastSizeDims="all",AdditionalInput={missingflag},Vectorized=false);
	end
end