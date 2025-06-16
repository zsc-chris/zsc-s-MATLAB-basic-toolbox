function ret=mldivide(self,other)
%\	Left array divide for DNT matrix
%	ret=self\other
%	ret=MLDIVIDE(self,other)
%	MLDIVIDE(\) is an alias for ldivide(.\).
%
%	See also DNT/ldivide, mldivide, DNT

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