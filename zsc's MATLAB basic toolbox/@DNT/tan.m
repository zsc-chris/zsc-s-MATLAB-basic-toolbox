function ret=tan(self)
%TAN	Tangent of DNT in radians
%	ret=TAN(self)
%
%	See also tan, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@tan,self);
end