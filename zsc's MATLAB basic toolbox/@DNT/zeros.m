function ret=zeros(varargin)
%DNT.zeros	Zeros DNT
%	ret=DNT.zeros(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=ZEROS(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> DNT.zeros([3,2],["a","b"],"single","gpuArray")
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	>> ZEROS("a",3,"b",2,"single","gpuArray","DNT")
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	See also zeros, DNT

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
	ret=DNT(zeros(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end