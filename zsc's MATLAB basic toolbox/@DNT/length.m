function ret=length(self)
%LENGTH	Length of DNT
%	ret=LENGTH(self)
%	Not recommended, as its definition is too bugged.
%
%	See also length, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	ret=length(gather(self));
end