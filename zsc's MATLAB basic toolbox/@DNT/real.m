function ret=real(self)
%REAL	Complex real part of DNT
%	ret=REAL(self)
%
%	See also real, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@real,self);
end