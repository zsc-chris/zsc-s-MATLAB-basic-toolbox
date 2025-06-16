function ret=mod(self,other)
%MOD	Modulus after division of DNT
%	ret=MOD(self,other)
%
%	See also mod, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@mod,self,other);
end