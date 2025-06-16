function ret=randn(varargin)
%DNT.randn	DNT of normally distributed pseudorandom numbers
%	ret=DNT.randn([s,]sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=RANDN([s,]sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> gpurng default
%	>> DNT.randn([3,2],["a","b"],"single","gpuArray")
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b               1          2
%	    a
%
%	    1              -1.3724    -0.9203
%	    2              -0.3716     1.2682
%	    3              -0.0372    -2.2682
%
%	>> RANDN("a",3,"b",2,"single","gpuArray","DNT")
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b               1          2
%	    a
%
%	    1              -0.1655    -0.8487
%	    2               0.8213     1.6462
%	    3              -1.8927    -0.8962
%
%	See also randn, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret DNT
	end
	if ~isempty(varargin)&&isa(varargin{1},"RandStream")
		s=varargin(1);
		varargin=varargin(2:end);
	else
		s={};
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
	ret=DNT(randn(s{:},paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end