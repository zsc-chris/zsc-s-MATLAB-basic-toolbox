function ret=sinpi(self)
%SINPI	Compute sin(X*pi) accurately
%	ret=SINPI(self)
%
%	See also sinpi, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sinpi,self);
end