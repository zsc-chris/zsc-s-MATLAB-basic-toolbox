function ret=mtimes(self,other)
%*	DNT multiply
%	ret=self*other
%	ret=MTIMES(self,other)
%	MTIMES(*) is an alias for times(.*).
%
%	See also mtimes, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@times,self,other);
end