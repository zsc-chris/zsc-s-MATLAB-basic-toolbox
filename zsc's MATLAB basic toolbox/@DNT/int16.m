function ret=int16(self)
%int16	Convert DNT to signed 16-bit integer
%	ret=int16(self)
%
%	See also int16, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@int16,self);
end