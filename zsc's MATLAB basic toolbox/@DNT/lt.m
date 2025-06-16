function ret=lt(self,other)
%<	Less than for DNT
%	ret=self<other
%	ret=LT(self,other)
%
%	See also lt, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@lt,self,other);
end