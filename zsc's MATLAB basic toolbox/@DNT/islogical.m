function ret=islogical(self)
%ISLOGICAL	True for logical DNT
%	ret=ISLOGICAL(self)
%
%	See also islogical, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=islogical(gather(self));
end