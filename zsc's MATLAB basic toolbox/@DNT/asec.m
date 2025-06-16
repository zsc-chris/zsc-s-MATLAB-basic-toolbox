function ret=asec(self)
%ASEC	Inverse secant of DNT, result in radians
%	ret=ASEC(self)
%
%	See also asec, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@asec,self);
end