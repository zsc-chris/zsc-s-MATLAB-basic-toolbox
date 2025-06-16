function [ret1,ret2]=bounds(self,dims,missingflag)
%BOUNDS	Smallest and largest elements of DNT
%	[ret1,ret2]=BOUNDS(self,dims=self.dimnames,missingflag="omitmissing")
%	is equivalent to
%	"[ret1,ret2]=funcat(@min,@max)(self,[],dims,missingflag)".
%
%	See also bounds, DNT, DNT/min, DNT/max

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
	end
	arguments(Output)
		ret1 DNT
		ret2 DNT
	end
	ret1=min(self,[],dims,missingflag);
	ret2=max(self,[],dims,missingflag);
end