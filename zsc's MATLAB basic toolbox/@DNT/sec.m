function ret=sec(self)
%SEC	Secant of DNT in radians
%	ret=SEC(self)
%
%	See also sec, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sec,self);
end