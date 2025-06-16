function ret=rescale(self,l,u,options)
%RESCALE	Rescales the range of data
%	ret=RESCALE(self,l=0,u=1,*,InputMin=min(self),InputMax=max(self))
%
%	See also rescale, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		l DNT{mustBeNumeric}=0
		u DNT{mustBeNumeric}=1
		options.InputMin DNT{mustBeNumeric}=min(self)
		options.InputMax DNT{mustBeNumeric}=max(self)
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@(self,l,u,InputMin,InputMax)rescale(self,l,u,InputMin=InputMin,InputMax=InputMax),self,l,u,options.InputMin,options.InputMax);
end