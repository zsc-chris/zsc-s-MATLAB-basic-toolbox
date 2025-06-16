function ret=coth(self)
%COTH	Hyperbolic cotangent of DNT
%	ret=COTH(self)
%
%	See also coth, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@coth,self);
end