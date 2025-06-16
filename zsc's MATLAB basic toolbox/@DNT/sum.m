function ret=sum(self,dims,nanflag)
%SUM	Sum of elements of DNT
%	ret=SUM(self,dims=self.dimnames,nanflag="includemissing") reduces self
%	along dims by @SUM.
%
%	Example:
%	>> SUM(DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              4
%	    2              6
%
%	>> SUM(DNT([1,2;3,4],["a","b"]),"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              3
%	    2              7
%
%	>> SUM(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  DNT double scalar
%
%	    10
%
%	>> SUM(DNT([1,2;3,4],["a","b"]),[])
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
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret DNT
	end
	if ~isUnderlyingType(self,"string")
		ret=fevalalong(@sum,dims,self,AdditionalInput={nanflag});
	else
		if contains(nanflag,"include")
			ret=join(self,"",dims);
		else
			self=feval(@(x)fillmissing(x,"constant",""),self);
			ret=join(self,"",dims);
		end
	end
end