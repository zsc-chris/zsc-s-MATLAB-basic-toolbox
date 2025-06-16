function ret=true(varargin)
%DNT.true	True DNT
%	ret=DNT.true(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=TRUE(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> DNT.true([3,2],["a","b"],"gpuArray")
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%	    3              1    1
%
%	>> TRUE("a",3,"b",2,"gpuArray","DNT")
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%	    3              1    1
%
%	See also true, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
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
	ret=DNT(true(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end