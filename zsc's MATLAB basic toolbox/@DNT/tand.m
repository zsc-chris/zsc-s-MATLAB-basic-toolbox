function ret=tand(self)
%TAND	Tangent of DNT in degrees
%	ret=TAND(self)
%
%	See also tand, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@tand,self);
end