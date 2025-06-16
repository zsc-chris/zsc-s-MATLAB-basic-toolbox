function ret=csc(self)
%CSC	Cosecant of DNT in radians
%	ret=CSC(self)
%
%	See also csc, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@csc,self);
end