function ret=uplus(self)
%+	Unary plus for DNT
%	ret=+self
%	ret=UPLUS(self)
%
%	See also uplus, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@uplus,self);
end