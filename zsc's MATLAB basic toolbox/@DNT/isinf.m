function ret=isinf(self)
%ISINF	True for infinite elements of DNT
%	ret=ISINF(self)
%
%	See also ISINF, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@isinf,self);
end