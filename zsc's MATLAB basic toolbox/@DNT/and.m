function ret=and(self,other)
%&	Logical AND for DNT
%	ret=self&other
%	ret=AND(self,other)
%
%	See also and, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@and,self,other);
end