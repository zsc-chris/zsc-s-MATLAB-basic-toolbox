function ret=acos(self)
%ACOS	Inverse cosine of DNT, result in radians
%	ret=ACOS(self)
%
%	See also acos, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@acos,self);
end