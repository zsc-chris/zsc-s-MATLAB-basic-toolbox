function ret=horzcat(DNTs)
%HORZCAT	Horizontal concatenation of DNTs
%	ret=HORZCAT(*DNTs) implements [*DNTs] for DNTs. It is equivalent to
%	ret=cat(2,*DNTs).
%
%	See also horzcat, DNT/cat, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		DNTs
	end
	arguments(Output)
		ret DNT
	end
	ret=cat(2,DNTs{:});
end