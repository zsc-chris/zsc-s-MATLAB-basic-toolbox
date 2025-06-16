function B=squeeze(A,dims)
%zsc.squeeze	Improved version of MATLAB SQUEEZE
%	B=zsc.squeeze(A,dims) adds a dimension keyword to the builtin version
%	that allows one to remove only certain 1-sized dimensions.
%
%	Note: this function squeezes row vector to column, which is different.
%
%	See also squeeze

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		dims(1,:)double{mustBeInteger,mustBePositive}=1:ndims(A)
	end
	dims=unique(dims);
	sz=size(A);
	dims=dims(dims<=numel(sz));
	zsc.assert(all(sz(dims)==1),"ZSC:zsc:squeeze:dimensionNotSingleton","Cannot squeeze non-singleton dimension.")
	sz(dims(sz(dims)==1))=[];
	B=reshape(A,paddata(sz,[1,2],FillValue=1));
end