function ret=double(self)
%DOUBLE	Convert DNT to double precision
%	ret=DOUBLE(self)
%
%	See also double, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@double,self);
end