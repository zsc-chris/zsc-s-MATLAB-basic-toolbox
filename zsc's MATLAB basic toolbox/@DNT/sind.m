function ret=sind(self)
%SIND	Sine of DNT in degrees
%	ret=SIND(self)
%
%	See also sind, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sind,self);
end