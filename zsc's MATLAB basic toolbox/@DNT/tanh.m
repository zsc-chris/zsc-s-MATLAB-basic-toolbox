function ret=tanh(self)
%TANH	Hyperbolic tangent of DNT
%	ret=TANH(self)
%
%	See also tanh, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@tanh,self);
end