function ret=fix(self)
%FIX	Round DNT towards zero
%	ret=FIX(self)
%
%	See also fix, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@fix,self);
end