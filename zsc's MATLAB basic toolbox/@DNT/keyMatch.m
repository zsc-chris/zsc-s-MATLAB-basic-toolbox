function ret=keyMatch(~,~)
%keyMatch	True if two keys are the same
%	ret=keyMatch(~,~) is not supported for DNT.
%
%	See also keyMatch, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		~
		~
	end
	arguments(Output)
		ret logical
	end
	error(message("parallel:array:InvalidDictionaryKey","DNT"))
end