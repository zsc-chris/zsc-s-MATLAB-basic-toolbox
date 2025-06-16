function ret=plus(self,other)
%+	Plus for DNT
%	ret=self+other
%	ret=PLUS(self,other)
%
%	See also plus, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@plus,self,other);
end