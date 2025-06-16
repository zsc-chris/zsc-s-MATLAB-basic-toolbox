function TF=isDNT(X)
%ISDNT	True for a DNT
%	TF=ISDNT(X) returns true for a DNT and false otherwise.
%
%	See also DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		X
	end
	arguments(Output)
		TF(1,1)logical
	end
	TF=isa(X,"DNT");
end