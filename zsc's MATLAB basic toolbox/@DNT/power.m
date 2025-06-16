function ret=power(self,other)
%.^	Array power for DNT
%	ret=self.^other
%	ret=POWER(self,other)
%
%	See also power, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@power,self,other);
end