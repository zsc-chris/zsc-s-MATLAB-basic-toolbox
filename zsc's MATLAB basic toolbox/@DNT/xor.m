function ret=xor(self,other)
%XOR	Logical EXCLUSIVE OR for DNT
%	ret=XOR(self,other)
%
%	See also xor, DNT
%
%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@xor,self,other);
end