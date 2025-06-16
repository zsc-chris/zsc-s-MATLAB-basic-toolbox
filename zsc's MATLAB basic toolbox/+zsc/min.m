function [M,I]=min(A,B,dims,missingflag,flags,options)
%zsc.min	Improved version of MATLAB MIN
%	[M,I]=zsc.min(A,[],dims=1:ndims(self),
%	missingflag="omitmissing"[,"linear"],*,ComparisonMethod="auto")
%	supports returning I without "linear" when dims is not scalar (I is
%	linear indices in dims, not 1:ndims(self)), and returns an NaN array
%	and a zero array if prod(size(A,dims))==0.
%	M=zsc.min(A,B,[],missingflag="omitmissing",*,ComparisonMethod="auto")
%
%	Example:
%	>> [M,I]=zsc.min(reshape([1:7,nan],[2,2,2]),[],[1,3])
%
%	M =
%
%	     1     3
%
%
%	I =
%
%	     1     1
%
%	>> [M,I]=zsc.min(reshape([1:7,nan],[2,2,2]),[],[1,3],"includemissing","linear")
%
%	M =
%
%	     1   NaN
%
%
%	I =
%
%	     1     8
%
%	>> [M,I]=zsc.min([],[])
%
%	M =
%
%	   NaN
%
%
%	I =
%
%	     0
%
%	>> zsc.min([1,2;3,4],[3,4;1,2])
%
%	ans =
%
%	     1     2
%	     1     2
%
%	See also min

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		A
		B=[]
		dims(1,:){mustBeInteger,mustBePositive}=ifinline(isequal(B,[]),@()find(size(A)~=1),@()[])
		missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
	end
	arguments(Input,Repeating)
		flags{mustBeTrue("@(flag)isequal(flag,[])||succeeds(@()assert(startsWith(""linear"",flag)))",flags,VariableNames="flags")}
	end
	arguments(Input)
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		M
		I
	end
	dstar=dstarclass;
	if isequal(B,[])
		zsc.assert(numel(flags)<=1,message("MATLAB:min:repeatedFlagLinear"))
		[M,I]=min(A,B,dims,missingflag,"linear",dstar{options});
		if isempty(flags)
			[tmp{1:max(ndims(A),max(dims))}]=zsc.ind2sub(size(A),I);
			I=zsc.sub2ind(size(A,dims),tmp{dims});
		end
		if isempty(M)
			M=resize(M,1,Dimension=dims,FillValue=nan);
			I=resize(I,1,Dimension=dims);
		end
	else
		zsc.assert(isempty(dims),message("MATLAB:min:caseNotSupported"))
		zsc.assert(nargout<2,message("MATLAB:min:TwoInTwoOutCaseNotSupported"))
		zsc.assert(isempty(flags),message("MATLAB:min:linearNotSupported"))
		M=min(A,B,missingflag,dstar{options});
	end
end