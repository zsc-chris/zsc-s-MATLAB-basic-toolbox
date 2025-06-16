function ret=sign(self)
%SIGN	Signum function for DNT
%	ret=SIGN(self)
%
%	See also sign, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sign,self);
end