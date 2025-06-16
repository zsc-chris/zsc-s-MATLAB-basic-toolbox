function ret=tall(self)
%TALL	Convert DNT to tall
%	ret=TALL(self)
%
%	See also tall

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@tall,self);
end