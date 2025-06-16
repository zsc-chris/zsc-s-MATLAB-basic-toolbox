function ret=isequaln(DNTs)
%ISEQUALN	True if DNTs are numerically equal
%	ret=ISEQUALN(*DNTs)
%
%	Note: DNTs are considered equal only if their value and dimnames are
%	same with each other.
%
%	Example:
%	>> ISEQUALN(DNT([1,2;3,4]),DNT([1,2;3,4],["a","b"]))
%
%	ans =
%
%	  logical
%
%	   0
%
%	>> ISEQUALN(DNT([1,2;3,4]),[1,2;3,4])
%
%	ans =
%
%	  logical
%
%	   1
%
%	See also isequaln, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		DNTs
	end
	arguments(Output)
		ret logical
	end
	DNTs=cellfun(@(x)ifinline(isa(x,"DNT"),@()gather(x),@()x),DNTs,UniformOutput=false);
	ret=isequaln(DNTs{:});
end