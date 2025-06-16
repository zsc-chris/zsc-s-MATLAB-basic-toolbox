function [ret,lags]=xcov(self,other,dims,maxlag,scaleopt)
%XCOV	Cross-covariance function estimates
%	ret=XCOV(self,other,dims=union(self.dimnames,other.dimnames),maxlag=[],
%	scaleopt="none") calculates pairwise cross-covariance along dims.
%
%	Example:
%	>> XCOV(DNT([1,2;3,4;5,6],["a","b"]),DNT([1,2;2,3;1,4],["a","b"]),"a")
%
%	ans =
%
%	  5×2 DNT double matrix
%
%	         b                  1             2
%	    a
%
%	    1                  0.6667            -2
%	    2                 -1.3333             0
%	    3              3.7007e-17             4
%	    4                  1.3333             0
%	    5                 -0.6667            -2
%
%	See also xcov, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
		maxlag double{mustBeTrue("@(maxlag)isequal(maxlag,[])||isscalar(maxlag)&&isinteger(maxlag)&&maxlag>=0",maxlag,VariableNames="maxlag")}=[]
		scaleopt(1,1)string{mustBeMember(scaleopt,["none","biased","unbiased","normalized","coeff"])}="none"
	end
	arguments(Output)
		ret DNT
		lags DNT
	end
	[ret,lags]=fevalalong(@xcov_,dims,self,other,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={maxlag,scaleopt});
end
function [ret,lags]=xcov_(self,other,maxlag,scaleopt)
	star=starclass;
	N=max(size(self,1),size(other,1));
	[ret,lags]=xcov([paddata(self,N,dimension=1),paddata(other,N,dimension=1)],star{ifinline(isequal(maxlag,[]),@(){},@(){maxlag})}{:},scaleopt);
	ret=reshape(ret,numel(lags),sqrt(size(ret,2)),sqrt(size(ret,2)));
	ret=ret(:,end/2+1:end,1:end/2);
	ret=ret(:,sub2ind(size(ret,2:3),1:size(ret,2),1:size(ret,3)));
	lags=lags';
end