function ret=le(self,other)
%<=	Less than or equal for DNT
%	ret=self<=other
%	ret=LE(self,other)
%
%	See also le, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@le,self,other);
end