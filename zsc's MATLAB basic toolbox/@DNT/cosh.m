function ret=cosh(self)
%COSH	Hyperbolic cosine of DNT
%	ret=COSH(self)
%
%	See also cosh, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@cosh,self);
end