function [Lia,Locb]=ismember(A,B,flags)
%zsc.ismember	Improved version of MATLAB ISMEMBER
%	[Lia,Locb]=ismember(A,B,flags) tolerates any kinds of input.
%
%	See also ismember

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		A
		B
	end
	arguments(Input,Repeating)
		flags(1,1)string
	end
	arguments(Output)
		Lia
		Locb
	end
	[Lia,Locb]=ismember(arrayfun(@keyHash,A),arrayfun(@keyHash,B),flags{:});
	Lia(ismissing(A))=false;
	Locb(ismissing(A))=0;
end