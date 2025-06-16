function ret=isrow(self)
%ISROW	True if input DNT is a vector
%	ret=ISROW(self)
%	ISROW is an alias for isvector
%
%	See also DNT/isvector, isrow, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isvector(self);
end