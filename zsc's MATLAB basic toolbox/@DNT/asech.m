function ret=asech(self)
%ASECH	Inverse hyperbolic secant of DNT
%	ret=ASECH(self)
%
%	See also asech, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@asech,self);
end