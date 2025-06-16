function ret=vertcat(DNTs)
%VERTCAT	Vertical concatenation of DNTs
%	ret=VERTCAT(*DNTs) implements [*DNTs] for DNTs. It is equivalent to
%	ret=cat(1,*DNTs).
%
%	See also vertcat, DNT/cat, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		DNTs
	end
	arguments(Output)
		ret DNT
	end
	ret=cat(1,DNTs{:});
end