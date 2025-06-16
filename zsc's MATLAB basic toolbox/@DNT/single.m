function ret=single(self)
%SINGLE	Convert DNT to single precision
%	ret=SINGLE(self)
%
%	See also single, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@single,self);
end