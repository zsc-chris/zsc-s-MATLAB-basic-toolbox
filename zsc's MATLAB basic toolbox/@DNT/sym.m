function ret=sym(self)
%SYM	Convert DNT to sym
%	ret=SYM(self)
%
%	Note: For string input, str2sym is called.
%
%	See also sym

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(ifinline(isUnderlyingType(self,"string"),@()@str2sym,@()@sym),self);
end