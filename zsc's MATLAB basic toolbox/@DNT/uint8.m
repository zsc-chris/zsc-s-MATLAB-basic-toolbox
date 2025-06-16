function ret=uint8(self)
%uint8	Convert DNT to unsigned 8-bit integer
%	ret=uint8(self)
%
%	See also uint8, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@uint8,self);
end