function ret=int64(self)
%int64	Convert DNT to signed 64-bit integer
%	ret=int64(self)
%
%	See also int64, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@int64,self);
end