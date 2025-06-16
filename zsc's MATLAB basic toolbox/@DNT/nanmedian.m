function ret=nanmedian(self,dims)
%NANMEDIAN	Median value, ignoring NaNs
%	ret=NANMEDIAN(self,dims=self.dimnames) reduces self along dims by
%	@NANMEDIAN.
%
%	See also nanmedian, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	ret=median(self,dims,"omitnan");
end