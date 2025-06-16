function ret=flatten(self,dims)
%FLATTEN	Flatten array
%	ret=FLATTEN(self,dims) flattens dims into the first dimension.

%	Copyright 2025 Chris H. Zhao
	arguments
		self
		dims(1,:)double=1:ndims(self)
	end
	if isempty(dims)
		ret=shiftdim(self,-1);
		return
	end
	maxdim=max(ndims(self),max(dims));
	ret=zsc.permute(self,[setdiff(1:maxdim,dims),dims]);
	ret=subsref(ret,substruct("()",repmat({':'},[1,maxdim-numel(dims)+1])));
	ret=zsc.permute(ret,[maxdim-numel(dims)+1,1:maxdim-numel(dims)]);
end