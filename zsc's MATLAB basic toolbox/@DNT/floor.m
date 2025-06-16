function ret=floor(self)
%FLOOR	Round DNT towards minus infinity
%	ret=FLOOR(self)
%
%	See also floor, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@floor,self);
end