function ret=codistributed(self)
%CODISTRIBUTED	Convert DNT to codistributed
%	ret=CODISTRIBUTED(self)
%
%	See also codistributed

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@codistributed,self);
end