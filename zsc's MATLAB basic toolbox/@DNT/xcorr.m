function [ret,lags]=xcorr(self,other,dims,maxlag,scaleopt)
%XCORR	Cross-correlation function estimates
%	ret=XCORR(self,other,dims=union(self.dimnames,other.dimnames),
%	maxlag=[],scaleopt="none") calculates pairwise cross-correlation along
%	dims.
%
%	Example:
%	>> XCORR(DNT([1,2;3,4;5,6],["a","b"]),DNT([1,2;2,3;1,4],["a","b"]),"a")
%
%	ans =
%
%	  5×2 DNT double matrix
%
%	         b              1         2
%	    a
%
%	    1                   1    8.0000
%	    2              5.0000        22
%	    3                  12        40
%	    4                  13        26
%	    5                   5        12
%
%	See also xcorr, DNT

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
	[ret,lags]=fevalalong(@xcorr_,dims,self,other,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={maxlag,scaleopt});
end
function [ret,lags]=xcorr_(self,other,maxlag,scaleopt)
	star=starclass;
	N=max(size(self,1),size(other,1));
	[ret,lags]=xcorr([paddata(self,N,dimension=1),paddata(other,N,dimension=1)],star{ifinline(isequal(maxlag,[]),@(){},@(){maxlag})}{:},scaleopt);
	ret=reshape(ret,numel(lags),sqrt(size(ret,2)),sqrt(size(ret,2)));
	ret=ret(:,end/2+1:end,1:end/2);
	ret=ret(:,sub2ind(size(ret,2:3),1:size(ret,2),1:size(ret,3)));
	lags=lags';
end