function ret=getdiag(self,dims)
%GETDIAG	Get diagonal element
%	ret=GETDIAG(self,dims) get the diagonal elements of dims into the first
%	dimension.

%	Copyright 2025 Chris H. Zhao
	arguments
		self
		dims(1,:)double=[1,2]
	end
	if isempty(dims)
		try
			ret=shiftdim(self,-1);
		catch ME
			ret=self;
			if isscalar(ret)
			elseif isempty(ret)
				empty=str2func(class(ret)+".empty");
				ret=empty([1,size(ret)]);
			else
				rethrow(ME)
			end
		end
		return
	end
	maxdim=max(ndims(self),max(dims));
	ret=zsc.permute(self,[setdiff(1:maxdim,dims),dims]);
	star=starclass;
	sz=size(ret,maxdim-numel(dims)+1:maxdim);
	try
		zsc.assert(~matlab.indexing.isScalarClass(ret))
		ret=subsref(ret,substruct("()",[repmat({':'},[1,maxdim-numel(dims)]),{zsc.sub2ind(sz,star{repmat({(1:min(sz))'},[1,numel(sz)]),2}{1})}]));
	catch ME
		if isscalar(ret)
		elseif isempty(ret)
			empty=str2func(class(ret)+".empty");
			ret=empty([size(ret,1:maxdim-numel(dims)),min(size(ret,maxdim-numel(dims)+1:maxdim))]);
		else
			rethrow(ME)
		end
	end
	ret=zsc.permute(ret,[maxdim-numel(dims)+1,1:maxdim-numel(dims)]);
end