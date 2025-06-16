function ret=eqn(A,B)
%EQN	Equal, treating NaNs as equal
%	ret=EQN(A,B) is the same as A==B but treats missing as equal.
%
%	See also eq

%	Copyright 2025 Chris H. Zhao
	ret=arrayfun(@keyHash,A)==arrayfun(@keyHash,B);
end