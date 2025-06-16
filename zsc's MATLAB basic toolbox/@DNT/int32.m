function ret=int32(self)
%int32	Convert DNT to signed 32-bit integer
%	ret=int32(self)
%
%	See also int32, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@int32,self);
end