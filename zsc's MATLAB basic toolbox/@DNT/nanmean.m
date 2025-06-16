function ret=nanmean(self,dims)
%NANMEAN	Mean value, ignoring NaNs
%	ret=NANMEAN(self,dims=self.dimnames) reduces self along dims by
%	@NANMEAN.
%
%	See also nanmean, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	ret=mean(self,dims,"omitnan");
end