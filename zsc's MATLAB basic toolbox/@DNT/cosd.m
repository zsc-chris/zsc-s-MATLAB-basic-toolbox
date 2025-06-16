function ret=cosd(self)
%COSD	Cosine of DNT in degrees
%	ret=COSD(self)
%
%	See also cosd, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@cosd,self);
end