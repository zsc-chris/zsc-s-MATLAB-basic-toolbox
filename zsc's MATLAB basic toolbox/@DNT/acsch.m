function ret=acsch(self)
%ACSCH	Inverse hyperbolic cosecant of DNT
%	ret=ACSCH(self)
%
%	See also acsch, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@acsch,self);
end