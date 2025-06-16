function ret=mrdivide(self,other)
%/	Right array divide for DNT matrix
%	ret=self/other
%	ret=MRDIVIDE(self,other)
%	MRDIVIDE(/) is an alias for rdivide(./).
%
%	See also DNT/rdivide, mrdivide, DNT

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