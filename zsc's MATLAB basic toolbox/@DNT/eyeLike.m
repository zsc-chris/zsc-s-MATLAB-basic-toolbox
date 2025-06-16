function ret=eyeLike(self,sz)
%eyeLike	eyeLike DNT
%	ret=eyeLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=eye(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> eyeLike(gpuArray(single(DNT)),[3,2],["a","b"])
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
%	>> eye(a=3,b=2,like=gpuArray(single(DNT)))
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
%	See also eye, DNT, DNT/eye
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		sz
	end
	arguments(Output)
		ret DNT
	end
	ret=zeros(sz{:},like=self);
	if isscalar(ret)
		ret=ret+1;
	else
		sub=repmat({1:min(size(ret))},[1,ndims(ret)]);
		ret.data(zsc.sub2ind(size(ret),sub{:}))=ones(min(size(ret)),like=self).data;
	end
end