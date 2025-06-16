function ret=times(self,other)
%.*	DNT multiply
%	ret=self.*other
%	ret=TIMES(self,other)
%
%	See also times, DNT

%	Copyright 2025 Chirs H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@times,self,other);
end