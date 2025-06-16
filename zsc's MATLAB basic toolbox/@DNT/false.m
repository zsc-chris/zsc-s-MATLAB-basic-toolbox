function ret=false(varargin)
%DNT.false	False DNT
%	ret=DNT.false(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=FALSE(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> DNT.false([3,2],["a","b"],"gpuArray")
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	>> FALSE("a",3,"b",2,"gpuArray","DNT")
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	See also false, DNT

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
	zsc.assert(isempty(sz)||isequaln(sort(zsc.cell2mat(sz(1,:))),unique(zsc.cell2mat(sz(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=DNT(false(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end