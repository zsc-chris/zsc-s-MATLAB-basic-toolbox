function ret=acsc(self)
%ACSC	Inverse cosecant of DNT, result in radians
%	ret=ACSC(self)
%
%	See also acsc, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@acsc,self);
end