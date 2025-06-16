function ret=uint64(self)
%uint64	Convert DNT to unsigned 64-bit integer
%	ret=uint64(self)
%
%	See also uint64, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@uint64,self);
end