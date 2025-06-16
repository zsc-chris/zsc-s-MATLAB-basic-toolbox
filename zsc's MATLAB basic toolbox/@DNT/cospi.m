function ret=cospi(self)
%COSPI	Compute cos(X*pi) accurately
%	ret=COSPI(self)
%
%	See also cospi, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@cospi,self);
end