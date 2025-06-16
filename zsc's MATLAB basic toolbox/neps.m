function d=neps(x,options)
%NEPS	Spacing of floating point numbers, zero-ward
%	NEPS(x=1) is the positive distance from abs(x) to the next smaller in
%	magnitude floating point number of the same precision as x.
%	x may be either double precision or single precision.
%	For all x, NEPS(x) is equal to NEPS(abs(x)).
%
%	NEPS(classname) returns the positive distance from 1.0 to the previous
%	floating point number in the precision of classname.
%
%	NEPS("double") is the same as NEPS, or NEPS(1.0).
%	NEPS("single") is the same as NEPS(single(1.0)), or single(2^-24).
%
%	NEPS(*,like) returns the positive distance from 1.0 to the last
%	floating point number in the precision of the numeric variable like,
%	with the same data type, sparsity, and complexity (real or complex) as
%	the numeric variable like.
%
%	See also eps

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		x=1
		options.like
	end
	arguments(Output)
		d
	end
	zsc.assert(nargin<1||isempty(fieldnames(options)),message("MATLAB:maxrhs"))
	if nargin==1
		zsc.assert(isUnderlyingType(x,"float"),message("MATLAB:eps:invalidClassName"))
		x=abs(x);
		d=eps(x-eps(x));
	else
		zsc.assert(isUnderlyingType(options.like,"float"),message("MATLAB:eps:invalidPrototype"))
		d=eps(1-eps("like",options.like));
	end
end