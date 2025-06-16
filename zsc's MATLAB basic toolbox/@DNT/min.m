function [ret,I]=min(self,other,dims,missingflag,flags,options)
%MIN	Smallest component of DNT
%	[ret,index]=MIN(self,[],dims=self.dimnames,
%	missingflag="omitmissing"[,"linear"],*,ComparisonMethod="auto") reduces
%	self along dims by @zsc.min.
%	ret=MIN(self,other,[],missingflag="omitmissing",*,
%	ComparisonMethod="auto")
%
%	Example:
%	>> [M,I]=MIN(DNT(reshape([1:7,nan],2,2,2),["a","b","c"]),[],["a","c"])
%
%	M =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1
%	    2              3
%
%
%	I =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1
%	    2              1
%
%	>> [M,I]=MIN(DNT(reshape([1:7,nan],2,2,2),["a","b","c"]),[],["a","c"],"includemissing","linear")
%
%	M =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1                1
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
%	    1              1
%	    2              8
%
%	>> [M,I]=MIN(DNT([],["a","b"]),[],"a")
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
%	>> MIN(DNT(1:3,"a"),DNT(1:3,"b"))
%
%	ans =
%
%	  3×3 DNT double matrix
%
%	         b         1    2    3
%	    a
%
%	    1              1    1    1
%	    2              1    2    2
%	    3              1    2    3
%
%	See also min, zsc.min, DNT

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
		zsc.assert(numel(flags)<=1,message("MATLAB:min:repeatedFlagLinear"))
		[ret,I]=fevalalong(@(self,dims,varargin)zsc.min(self,[],dims,varargin{:}),dims,self,AdditionalInput={missingflag,flags{:},dstar{options}});
	else
		zsc.assert(isempty(dims),message("MATLAB:min:caseNotSupported"))
		zsc.assert(nargout<2,message("MATLAB:min:TwoInTwoOutCaseNotSupported"))
		zsc.assert(isempty(flags),message("MATLAB:min:linearNotSupported"))
		ret=feval(@min,self,other,AdditionalInput={missingflag,dstar{options}});
	end
end