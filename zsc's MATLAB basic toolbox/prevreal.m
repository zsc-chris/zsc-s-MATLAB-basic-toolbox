function f=prevreal(x)
%PREVREAL	Previous real floating-point number
%	f=PREVREAL(x=1) returns the immediate predecessor in float set of each
%	value in x.
%
%	See also nextreal, eps, neps

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		x=1
	end
	arguments(Output)
		f
	end
	if x<0
		f=x-eps(x);
	else
		f=x-neps(x);
	end
end