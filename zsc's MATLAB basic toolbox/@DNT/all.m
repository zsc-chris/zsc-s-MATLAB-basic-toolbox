function ret=all(self,dims)
%ALL	True if all elements of a DNT are nonzero
%	ret=ALL(self,dims=self.dimnames) reduces self along dims by @ALL.
%
%	See also all, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
	end
	ret=fevalalong(@all,dims,self);
end