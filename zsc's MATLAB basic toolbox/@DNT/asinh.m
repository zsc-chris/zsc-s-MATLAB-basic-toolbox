function ret=asinh(self)
%ASINH	Inverse hyperbolic sine of DNT
%	ret=ASINH(self)
%
%	See also asinh, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@asinh,self);
end