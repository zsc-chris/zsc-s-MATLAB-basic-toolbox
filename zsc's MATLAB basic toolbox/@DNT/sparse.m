function ret=sparse(self)
%SPARSE	Create sparse DNT matrix
%	ret=SPARSE(self)
%	Note: Only this syntax is supported.
%
%	See also sparse, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@sparse,self);
end