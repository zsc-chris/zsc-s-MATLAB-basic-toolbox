function ret=isfinite(self)
%ISFINITE	True for finite elements of DNT
%	ret=ISFINITE(self)
%
%	See also isfinite, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@isfinite,self);
end