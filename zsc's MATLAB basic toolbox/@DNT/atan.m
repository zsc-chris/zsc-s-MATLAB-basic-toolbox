function ret=atan(self)
%ATAN	Inverse tangent of DNT, result in radians
%	ret=ATAN(self)
%
%	See also atan, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@atan,self);
end