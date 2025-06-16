function ret=cov(self,other,w,dims,nanflag)
%COV	Covariance
%	ret=COV(self,other,w=1,dims=union(self.dimnames,other.dimnames),
%	nanflag="includemissing") calculates pairwise covariance along dims.
%
%	Example:
%	>> [a,b]=deal(DNT([1,2;3,4],["a","b"]),DNT([3,1;4,2],["a","b"]));
%	>> COV(a,b,1,"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              0.5000
%	    2              0.5000
%
%	>> COV(a,b,1,"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              -0.5000
%	    2              -0.5000
%
%	See also cov, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
		w(1,1)double{mustBeMember(w,[0,1])}=1
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitrows","partialrows"])}="includemissing"
	end
	arguments(Output)
		ret DNT
	end
	ret=fevalalong(@cov_,dims,self,other,Mode="flattenall",KeepOtherDims=true,UnflattenOther=1,AdditionalInput={w,nanflag});
end
function ret=cov_(self,other,w,nanflag)
	arguments(Input)
		self
		other
		w(1,1)double{mustBeMember(w,[0,1])}=0
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitrows","partialrows"])}="includemissing"
	end
	tmp=[self,other];
	if size(tmp,1)==1
		ret=ifinline(w==0,@()nan(size(self),like=self),@()ternary(isfinite(self),0,nan));
		return
	end
	ret=cov(tmp,w,nanflag);
	ret=diag(ret(end/2+1:end,1:end/2))';
end