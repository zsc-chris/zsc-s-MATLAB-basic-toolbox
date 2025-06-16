function ret=int8(self)
%int8	Convert DNT to signed 8-bit integer
%	ret=int8(self)
%
%	See also int8, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@int8,self);
end