function ret=iscolumn(self)
%ISCOLUMN	True if input DNT is a vector
%	ret=ISCOLUMN(self)
%	ISCOLUMN is an alias for isvector
%
%	See also DNT/isvector, iscolumn, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isvector(self);
end