function ret=conj(self)
%CONJ	Complex conjugate of DNT
%	ret=CONJ(self)
%
%	See also conj, DNT

%	Copyright 2024–2025 Chris H. Zhao
	arguments
		self DNT
	end
	ret=feval(@conj,self);
end