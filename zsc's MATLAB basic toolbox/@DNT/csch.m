function ret=csch(self)
%CSCH	Hyperbolic cosecant of DNT
%	ret=CSCH(self)
%
%	See also csch, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@csch,self);
end