function ret=subsindex(self)
%SUBSINDEX	Subscript index for DNT
%	ret=SUBSINDEX(self) accepts a DNT input self, and returns the index ret
%	of zero-based integer values for use in indexing. The class of ret is
%	the same as the underlying class of self.
%
%	See also DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret
	end
	ret=self;
	if islogical(ret)
		ret=find(ret);
	end
	ret=gather(ret)-1;
end