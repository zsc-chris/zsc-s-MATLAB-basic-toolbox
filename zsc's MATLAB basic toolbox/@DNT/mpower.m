function ret=mpower(self,other)
%^	Array power for DNT
%	ret=self^other
%	ret=MPOWER(self,other)
%	MPOWER(^) is an alias for power(.^).
%
%	See also mpower, DNT

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