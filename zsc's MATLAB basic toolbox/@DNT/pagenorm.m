function ret=pagenorm(self,p)
%PAGENORM	Page-wise matrix norm
%	ret=PAGENORM(self,p) is the same as ret=norm(self,p,1,2).
%
%	See also DNT/norm, pagenorm, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		p(1,1)double=2
	end
	arguments(Output)
		ret DNT
	end
	ret=norm(self,p,1,2);
end