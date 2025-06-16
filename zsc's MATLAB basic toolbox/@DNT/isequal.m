function ret=isequal(DNTs)
%ISEQUAL	True if DNTs are numerically equal
%	ret=ISEQUAL(*DNTs)
%
%	Note: DNTs are considered equal only if their value and dimnames are
%	same with each other.
%
%	Example:
%	>> ISEQUAL(DNT([1,2;3,4]),DNT([1,2;3,4],["a","b"]))
%
%	ans =
%
%	  logical
%
%	   0
%
%	>> ISEQUAL(DNT([1,2;3,4]),[1,2;3,4])
%
%	ans =
%
%	  logical
%
%	   1
%
%	See also isequal, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Output)
		ret logical
	end
	ret=builtin("isequal",DNTs{:});
end