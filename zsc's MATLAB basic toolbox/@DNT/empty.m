function ret=empty(varargin,options)
%DNT.empty	Create empty array of class DNT
%	ret=DNT.empty(sz/(sz,dims)/*sz/**sz/mapping(**sz)[,[*dtypes/*,like]])
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>>>	DNT.empty([0,0,5],["a","b","c"],"single","gpuArray","DNT")
%
%	ans =
%
%	  0×0×5 empty DNT gpuArray single tensor with properties:
%
%	    dimnames: ["a"    "b"    "c"]
%
%	>> DNT.empty("a",0,"b",0,"c",5,"single","gpuArray")
%
%	ans =
%
%	  0×0×5 empty DNT gpuArray single tensor with properties:
%
%	    dimnames: ["a"    "b"    "c"]
%
%	See also empty, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Input)
		options.like
	end
	arguments(Output)
		ret DNT
	end
	ind=find(cellfun(@isnumeric,varargin),1,"last");
	if isempty(ind)
		dtypes=varargin;
		sz={};
	else
		if numel(varargin)>ind&&~isscalar(string(varargin{ind+1}))
			ind=ind+1;
		end
		dtypes=varargin(ind+1:end);
		sz=varargin(1:ind);
	end
	sz=parsedimargs([],sz);
	zsc.assert(prod(zsc.cell2mat(sz(2,:)))==0,message("MATLAB:class:emptyMustBeZero"))
	dstar=dstarclass;
	ret=createArray(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{1},dstar{options});
	for i=2:numel(dtypes)
		ret=feval(dtypes{i},ret);
	end
	ret=DNT(ret,zsc.cell2mat(sz(1,:)));
end