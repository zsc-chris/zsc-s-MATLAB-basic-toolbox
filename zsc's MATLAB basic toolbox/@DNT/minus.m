function ret=minus(self,other)
%-	Minus for DNT
%	ret=self-other
%	ret=MINUS(self,other)
%
%	See also minus, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@minus,self,other);
end