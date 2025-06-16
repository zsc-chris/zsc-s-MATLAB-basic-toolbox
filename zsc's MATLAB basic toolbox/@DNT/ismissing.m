function ret=ismissing(self,indicator)
%ISMISSING	Find missing entries
%	ret=ismissing(self,indicator=[])
%
%	See also ismissing, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		indicator=[]
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@ismissing,self,AdditionalInput={indicator});
end