function ret=rem(self,other)
%REM	Remainder after division of DNT
%	ret=REM(self,other)
%
%	See also rem, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@rem,self,other);
end