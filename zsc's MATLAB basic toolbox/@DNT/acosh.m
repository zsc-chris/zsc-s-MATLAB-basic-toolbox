function ret=acosh(self)
%ACOSH	Inverse hyperbolic cosine of DNT
%	ret=ACOSH(self)
%
%	See also acosh, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@acosh,self);
end