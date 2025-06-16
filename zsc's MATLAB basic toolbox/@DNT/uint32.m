function ret=uint32(self)
%uint32	Convert DNT to unsigned 32-bit integer
%	ret=uint32(self)
%
%	See also uint32, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@uint32,self);
end