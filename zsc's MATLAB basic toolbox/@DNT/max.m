function [ret,I]=max(self,other,dims,missingflag,flags,options)
%MAX	Largest component of DNT
%	[ret,index]=MAX(self,[],dims=self.dimnames,
%	missingflag="omitmissing"[,"linear"],*,ComparisonMethod="auto") reduces
%	self along dims by @zsc.max.
%	ret=MAX(self,other,[],missingflag="omitmissing",*,
%	ComparisonMethod="auto")
%
%	Example:
%	>> [M,I]=MAX(DNT(reshape([1:7,nan],2,2,2),["a","b","c"]),[],["a","c"])
%
%	M =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              6
%	    2              7
%
%
%	I =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              4
%	    2              3
%
%	>> [M,I]=MAX(DNT(reshape([1:7,nan],2,2,2),["a","b","c"]),[],["a","c"],"includemissing","linear")
%
%	M =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1                6
%	    2              NaN
%
%
%	I =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              6
%	    2              8
%
%	>> [M,I]=MAX(DNT([],["a","b"]),[],"a")
%
%	M =
%
%	  1 DNT double vector
%
%
%	    b
%
%	    1              NaN
%
%
%	I =
%
%	  1 DNT double vector
%
%
%	    b
%
%	    1              0
%
%	>> MAX(DNT(1:3,"a"),DNT(1:3,"b"))
%
%	ans =
%
%	  3×3 DNT double matrix
%
%	         b         1    2    3
%	    a
%
%	    1              1    2    3
%	    2              2    2    3
%	    3              3    3    3
%
%	See also max, zsc.max, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=ifinline(isequal(other,[]),@()1:ndims(self),@()[])
		missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
	end
	arguments(Input,Repeating)
		flags{mustBeTrue("@(flag)isequal(flag,[])||succeeds(@()assert(startsWith(""linear"",flag)))",flags,VariableNames="flags")}
	end
	arguments(Input)
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret DNT
		I DNT
	end
	dstar=dstarclass;
	if isequal(other,[])
		zsc.assert(numel(flags)<=1,message("MATLAB:max:repeatedFlagLinear"))
		[ret,I]=fevalalong(@(self,dims,varargin)zsc.max(self,[],dims,varargin{:}),dims,self,AdditionalInput={missingflag,flags{:},dstar{options}});
	else
		zsc.assert(isempty(dims),message("MATLAB:max:caseNotSupported"))
		zsc.assert(nargout<2,message("MATLAB:max:TwoInTwoOutCaseNotSupported"))
		zsc.assert(isempty(flags),message("MATLAB:max:linearNotSupported"))
		ret=feval(@max,self,other,AdditionalInput={missingflag,dstar{options}});
	end
end