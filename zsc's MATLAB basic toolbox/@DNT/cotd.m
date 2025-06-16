function ret=cotd(self)
%COTD	Cotangent of DNT in degrees
%	ret=COTD(self)
%
%	See also cotd, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@cotd,self);
end