function ret=ldivide(self,other)
%.\	Left array divide for DNT matrix
%	ret=self.\other
%	ret=LDIVIDE(self,other)
%
%	See also ldivide, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@ldivide,self,other);
end