function ret=exp(self)
%EXP	Exponential of DNT
%	ret=EXP(self)
%
%	See also exp, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@exp,self);
end