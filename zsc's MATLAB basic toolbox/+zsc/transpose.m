function B=transpose(A,dim)
%zsc.transpose	Improved version of MATLAB TRANSPOSE
%	B=zsc.transpose(A,dim) transposes two dimensions of a matrix.
%
%	See also transpose

%	Copyright 2024 Chris H. Zhao
	arguments
		A
		dim(1,2)double{mustBeInteger,mustBePositive}=1:2
	end
	dims=1:max(ndims(A),max(dim));
	tmp=dims(dim(1));
	dims(dim(1))=dims(dim(2));
	dims(dim(2))=tmp;
	B=zsc.permute(A,dims);
end