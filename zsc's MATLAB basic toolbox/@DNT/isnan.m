function ret=isnan(self)
%ISNAN	True for Not-a-Number elements of DNT
%	ret=ISNAN(self)
%
%	See also isnan, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@isnan,self);
end