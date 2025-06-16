function [ret,E]=log2(self)
%log2	Base 2 logarithm and dissect floating point number of DNT
%	ret=log2(self)
%	[ret,E]=log2(self)
%
%	See also log2, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
		E DNT
	end
	[ret,E]=feval(@log2,self);
end