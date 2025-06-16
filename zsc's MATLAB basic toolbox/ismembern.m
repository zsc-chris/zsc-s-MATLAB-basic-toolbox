function [Lia,Locb]=ismembern(A,B,flags)
%ISMEMBERN	True for set member, treating NaNs as equal
%	[Lia,Locb]=ISMEMBERN(A,B,*flags), where flags is a subset of
%	["rows","legacy"] returns whether each member of A is in B. Missing
%	values are treated equal.
%
%	See also ismember

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		A
		B
	end
	arguments(Input,Repeating)
		flags(1,1)string{mustBeMember(flags,["rows","legacy"])}
	end
	arguments(Output)
		Lia
		Locb
	end
	[Lia,Locb]=ismember(arrayfun(@keyHash,A),arrayfun(@keyHash,B),flags{:});
end