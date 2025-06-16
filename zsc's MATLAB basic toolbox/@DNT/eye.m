function ret=eye(varargin)
%DNT.eye	Identity DNT tensor
%	ret=DNT.eye(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes)
%	ret=EYE(sz/(sz,dims)/*sz/**sz/mapping(**sz),*dtypes,"DNT")
%
%	Note: For (sz,dims) syntax, dims should not be scalar so as not to be
%		identified as dtypes.
%	Note: One needs to overload this method for subclass.
%
%	Example:
%	>> DNT.eye([3,2],["a","b"],"single","gpuArray")
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              1    0
%	    2              0    1
%	    3              0    0
%
%	>> EYE("a",3,"b",2,"single","gpuArray","DNT")
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              1    0
%	    2              0    1
%	    3              0    0
%
%	See also eye, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret DNT
	end
	ret=zeros(varargin{:},"DNT");
	if isscalar(ret)
		ret=ret+1;
	else
		sub=repmat({1:min(size(ret))},[1,ndims(ret)]);
		ret.data(zsc.sub2ind(size(ret),sub{:}))=gather(ones(min(size(ret)),like=ret));
	end
end