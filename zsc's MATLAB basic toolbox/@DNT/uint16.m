function ret=uint16(self)
%uint16	Convert DNT to unsigned 16-bit integer
%	ret=uint16(self)
%
%	See also uint16, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@uint16,self);
end