function ret=eq(self,other)
%==	Equal for DNT
%	ret=self==other
%	ret=EQ(self,other)
%
%	See also eq, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@eq,self,other);
end