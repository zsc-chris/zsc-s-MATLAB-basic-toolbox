function ret=distributed(self)
%DISTRIBUTED	Convert DNT to distributed
%	ret=DISTRIBUTED(self)
%
%	See also distributed

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@distributed,self);
end