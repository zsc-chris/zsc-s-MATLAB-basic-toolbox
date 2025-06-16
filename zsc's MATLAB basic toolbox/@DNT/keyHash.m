function ret=keyHash(~)
%keyHash	Generates a hash code
%	ret=keyHash(~) is not supported for DNT.
%
%	See also keyHash, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		~
	end
	arguments(Output)
		ret uint64
	end
	error(message("parallel:array:InvalidDictionaryKey","DNT"))
end