function ret=or(self,other)
%|	Logical OR for DNT
%	ret=self|other
%	ret=OR(self,other)
%
%	See also or, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@or,self,other);
end