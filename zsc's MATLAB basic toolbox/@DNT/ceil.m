function ret=ceil(self)
%CEIL	Round DNT towards plus infinity
%	ret=CEIL(self)
%
%	See also ceil, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@ceil,self);
end