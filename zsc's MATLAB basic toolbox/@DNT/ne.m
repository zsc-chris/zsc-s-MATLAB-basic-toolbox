function ret=ne(self,other)
%~=	Not equal for DNT
%	ret=self~=other
%	ret=NE(self,other)
%
%	See also ne, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@ne,self,other);
end