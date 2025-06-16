function ret=round(self)
%ROUND	Round towards nearest integer for DNT
%	ret=ROUND(self)
%
%	See also round, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@round,self);
end