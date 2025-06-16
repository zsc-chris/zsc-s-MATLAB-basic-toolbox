function ret=cot(self)
%COT	Cotangent of DNT in radians
%	ret=COT(self)
%
%	See also cot, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@cot,self);
end