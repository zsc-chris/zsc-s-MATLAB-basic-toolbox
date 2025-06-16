function ret=string(self)
%STRING	Convert DNT to string
%	ret=STRING(self)
%
%	See also string

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@string,self);
end