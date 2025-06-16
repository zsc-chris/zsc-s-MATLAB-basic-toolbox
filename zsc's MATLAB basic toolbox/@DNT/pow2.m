function ret=pow2(self,E)
%pow2	Base 2 power and scale floating point number for DNT
%	ret=pow2(self)
%	ret=pow2(self,E)
%
%	See also pow2, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		E=[]
	end
	arguments(Output)
		ret DNT
	end
	if nargin==1
		ret=feval(@pow2,self);
	else
		ret=feval(@pow2,self,E);
	end
end