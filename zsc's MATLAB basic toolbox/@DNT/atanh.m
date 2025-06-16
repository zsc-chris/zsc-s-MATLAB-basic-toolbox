function ret=atanh(self)
%ATANH	Inverse hyperbolic tangent of DNT
%	ret=ATANH(self)
%
%	See also atanh, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@atanh,self);
end