function f=nextreal(x)
%NEXTREAL	Next real floating-point number
%	f=NEXTREAL(x=1) returns the immediate successor in float set of each
%	value in x.
%
%	See also prevreal, eps, neps

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		x=1
	end
	arguments(Output)
		f
	end
	if x<0
		f=x+neps(x);
	else
		f=x+eps(x);
	end
end