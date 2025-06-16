function ret=full(self)
%FULL	Convert sparse DNT matrix to full DNT matrix
%	ret=FULL(self)
%
%	See also full, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@full,self);
end