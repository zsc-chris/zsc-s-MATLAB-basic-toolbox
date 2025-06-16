function ret=eps(self,options)
%EPS	Spacing of floating point numbers for DNT
%	ret=EPS(self)
%	ret=EPS(*,like)
%
%	Example:
%	>> EPS(DNT(gpuArray(single([1,2;3,4])),["a","b"]))
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b                  1             2
%	    a
%
%	    1              1.1921e-07    2.3842e-07
%	    2              2.3842e-07    4.7684e-07
%
%	>> EPS(like=DNT(gpuArray(single([1,2;3,4])),["a","b"]))
%
%	ans =
%
%	  DNT gpuArray single scalar
%
%	  1.1921e-07
%
%	See also eps, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT=1
		options.like DNT
	end
	arguments(Output)
		ret DNT
	end
	zsc.assert(nargin<1||isempty(fieldnames(options)),message("MATLAB:maxrhs"))
	if nargin==1
		zsc.assert(isUnderlyingType(self,"float"),message("MATLAB:eps:invalidClassName"))
		ret=feval(@eps,self);
	else
		constructor=str2func(class(options.like));
		zsc.assert(isUnderlyingType(options.like,"float"),message("MATLAB:eps:invalidPrototype"))
		ret=constructor(eps(like=gather(options.like)));
	end
end