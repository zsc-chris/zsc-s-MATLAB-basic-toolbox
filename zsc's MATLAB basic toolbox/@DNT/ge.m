function ret=ge(self,other)
%>=	Greater than or equal for DNT
%	ret=self>=other
%	ret=GE(self,other)
%
%	See also ge, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@ge,self,other);
end