function ret=gt(self,other)
%>	Greater than for DNT
%	ret=self>other
%	ret=gt(self,other)
%
%	See also gt, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@gt,self,other);
end