function C=fftconvn(A,B,shape)
%FFTCONVN	N-dimensional FFT convolution
%	C=FFTCONVN(A,B,shape) uses FFT convolution, which gives almost the same
%	result as C=convn(A,B,shape), but significantly faster.
%
%	See also convn

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		A
		B
		shape(1,1)string{mustBeMember(shape,["full","same","valid"])}="full"
	end
	arguments(Output)
		C
	end
	ndims_=max(ndims(A),ndims(B));
	sz=size(A,1:ndims_)+size(B,1:ndims_)-1;
	if isreal(A)&&isreal(B)
		C=ifftn(fftn(A,sz).*fftn(B,sz),"symmetric");
	else
		C=ifftn(fftn(A,sz).*fftn(B,sz),"nonsymmetric");
	end
	switch shape
		case "same"
			C=subsref(C,substruct("()",arrayfun(@(sz1,sz2)(round((sz2-1)/2)+1:round((2*sz1+sz2-1)/2)),size(A,1:ndims_),size(B,1:ndims_),UniformOutput=false)));
			C=trimdata(C,size(A,1:ndims_),"side","both");
		case "valid"
			C=trimdata(C,size(A,1:ndims_)-size(B,1:ndims_)+1,"side","both");
	end
end