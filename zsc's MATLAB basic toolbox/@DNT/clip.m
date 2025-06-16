function ret=clip(self,lower,upper)
%CLIP	Clip data to range for DNT
%	ret=CLIP(self,lower,upper)
%
%	See also clip

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		lower DNT{mustBeNumeric}
		upper DNT{mustBeNumeric}
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@clip,self,lower,upper);
end