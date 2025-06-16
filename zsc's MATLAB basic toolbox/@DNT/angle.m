function ret=angle(self)
%ANGLE	Phase angle of DNT
%	ret=ANGLE(self)
%
%	See also angle, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@angle,self);
end