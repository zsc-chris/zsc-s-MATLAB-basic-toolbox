function ret=imag(self)
%IMAG	Complex imaginary part of DNT
%	ret=IMAG(self)
%
%	See also imag, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@imag,self);
end