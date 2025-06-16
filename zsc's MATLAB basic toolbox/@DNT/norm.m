function ret=norm(self,p,dims)
%NORM	Vector and matrix norms for DNT
%	ret=NORM(self,p,*dims) operates vector norm (numel(dims)<=1, pad dims
%	to {1:ndims(self)} if empty) or matrix norm (numel(dims)==2) on self.
%
%	Note: Row vector like [1,2,3] can be treated either as a matrix or as a
%	vector here depending on nargin=3/4. Its norm of p=1/inf will be
%	swapped.
%	Note: "fro" is unnecessary. The default nargin=1 mode is "fro".
%
%	Example:
%	>> NORM(ones("a",5,"b",5,"c",5,"DNT"),inf,["a","b"])
%
%	ans =
%
%	  5 DNT double vector
%
%
%	    c
%
%	    1              1
%	    2              1
%	    3              1
%	    4              1
%	    5              1
%
%	>> NORM(ones("a",5,"b",5,"c",5,"DNT"),inf,"a","b")
%
%	ans =
%
%	  5 DNT double vector
%
%
%	    c
%
%	    1              5
%	    2              5
%	    3              5
%	    4              5
%	    5              5
%
%	See also norm, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		p(1,1)double=2
	end
	arguments(Repeating)
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}
	end
	dims=paddata(dims,1,FillValue={1:ndims(self)});
	if isscalar(dims)
		ret=fevalalong(@norm,dims{:},self,Mode="flatten",AdditionalInput={p},Vectorized=false);
	else
		zsc.assert(numel(dims)==2,message("MATLAB:maxrhs"))
		for i=1:2
			dims{i}=parsedims(self.dimnames,dims{i});
		end
		zsc.assert(isscalar(dims{1})&&isscalar(dims{2}),"ZSC:DNT:multipleDimensions","In matrix mode, two dimensions as comma-separated list should be specified for norm.")
		dims=zsc.cell2mat(dims);
		dims=DNT.index(self.dimnames,dims);
		ret=fevalalong(@(self,p)norm([self;zeros([1,size(self,2)],like=self)],p),dims,self,AdditionalInput={p},Vectorized=false);
	end
end