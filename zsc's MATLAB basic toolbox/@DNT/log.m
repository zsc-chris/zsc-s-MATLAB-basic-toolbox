function ret=log(self)
%LOG	Natural logarithm of DNT
%	ret=LOG(self)
%
%	See also log, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@log,self);
end