function ret=log10(self)
%log10	Common (base 10) logarithm of DNT
%	ret=log10(self)
%
%	See also log10, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@log10,self);
end