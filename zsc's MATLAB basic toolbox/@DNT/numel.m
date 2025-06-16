function ret=numel(self)
%NUMEL	Number of elements in DNT
%	ret=NUMEL(self) returns the number of underlying elements, ret, in DNT
%	tensor self.
%
%	Note: Only nargin==1 is supported.
%
%	See also numel, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	ret=numel(gather(self));
end