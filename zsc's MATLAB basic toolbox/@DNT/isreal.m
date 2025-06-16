function ret=isreal(self)
%ISREAL	True for real DNT
%	ret=ISREAL(self)
%
%	See also isreal, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret logical
	end
	ret=isreal(gather(self));
end