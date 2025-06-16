function ret=logical(self)
%LOGICAL	Convert numeric values of DNT to logical
%	ret=LOGICAL(self)
%
%	See also logical, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@logical,self);
end