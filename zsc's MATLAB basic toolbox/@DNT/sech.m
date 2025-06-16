function ret=sech(self)
%SECH	Hyperbolic secant of DNT
%	ret=SECH(self)
%
%	See also sech, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sech,self);
end