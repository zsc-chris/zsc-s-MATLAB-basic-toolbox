function ret=isempty(self)
%ISEMPTY	True for empty DNT
%	ret=ISEMPTY(self)
%
%	See also isempty, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isempty(gather(self));
end