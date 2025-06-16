function ret=randi(varargin)
%DNT.randi	DNT of normally distributed pseudorandom numbers
%	ret=DNT.randi([s,]irange,sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=RANDI([s,]irange,sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> gpurng default
%	>> DNT.randi(5,[3,2],["a","b"],"single","gpuArray")
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              2    4
%	    2              3    1
%	    3              4    5
%
%	>> RANDI(5,"a",3,"b",2,"single","gpuArray","DNT")
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              4    3
%	    2              2    1
%	    3              1    5
%
%	See also randi, DNT

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
	zsc.assert(~isempty(varargin),message("MATLAB:minrhs"))
	irange=varargin{1};
	varargin=varargin(2:end);
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
	ret=DNT(randi(s{:},irange,paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end