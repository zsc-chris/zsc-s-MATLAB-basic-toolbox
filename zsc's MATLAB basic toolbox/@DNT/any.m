function ret=any(self,dims)
%ANY	True if any element of a DNT is nonzero or true
%	ret=ANY(self,dims=self.dimnames) reduces self along dims by @ANY.
%
%	See also any, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
	end
	ret=fevalalong(@any,dims,self);
end