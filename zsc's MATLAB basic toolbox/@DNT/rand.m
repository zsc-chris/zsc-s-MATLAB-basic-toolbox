function ret=rand(varargin)
%DNT.rand	DNT of uniformly distributed pseudorandom numbers
%	ret=DNT.rand([s,]sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=RAND([s,]sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> gpurng default
%	>> DNT.rand([3,2],["a","b"],"single","gpuArray")
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b              1         2
%	    a
%
%	    1              0.3640    0.7436
%	    2              0.5421    0.0342
%	    3              0.6543    0.8311
%
%	>> RAND("a",3,"b",2,"single","gpuArray","DNT")
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b              1         2
%	    a
%
%	    1              0.7040    0.5671
%	    2              0.2817    0.1726
%	    3              0.1163    0.9207
%
%	See also rand, DNT

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
	ret=DNT(rand(s{:},paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end