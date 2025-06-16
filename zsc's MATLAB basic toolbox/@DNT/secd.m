function ret=secd(self)
%SECD	Secant of DNT in degrees
%	ret=SECD(self)
%
%	See also secd, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@secd,self);
end