function ret=cos(self)
%COS	Cosine of DNT in radians
%	ret=COS(self)
%
%	See also cos, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
	end
	ret=feval(@cos,self);
end