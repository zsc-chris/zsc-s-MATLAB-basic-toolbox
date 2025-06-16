function ret=char(self)
%CHAR	Convert DNT to char
%	ret=CHAR(self)
%
%	See also char

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@char,self);
end