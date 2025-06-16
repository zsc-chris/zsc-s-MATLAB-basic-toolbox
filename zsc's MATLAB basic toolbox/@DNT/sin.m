function ret=sin(self)
%SIN	Sine of DNT in radians
%	ret=SIN(self)
%
%	See also sin, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sin,self);
end