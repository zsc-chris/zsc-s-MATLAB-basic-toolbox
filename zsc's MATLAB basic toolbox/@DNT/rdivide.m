function ret=rdivide(self,other)
%./	Right array divide for DNT matrix
%	ret=self./other
%	ret=RDIVIDE(self,other)
%
%	See also rdivide, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@rdivide,self,other);
end