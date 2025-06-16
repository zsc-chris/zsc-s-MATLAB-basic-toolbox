function ret=acoth(self)
%ACOTH	Inverse hyperbolic cotangent of DNT
%	ret=ACOTH(self)
%
%	See also acoth, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@acoth,self);
end