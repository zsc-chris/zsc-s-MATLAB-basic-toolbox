function ret=cscd(self)
%CSCD	Cosecant of DNT in degrees
%	ret=CSCD(self)
%
%	See also cscd, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@cscd,self);
end