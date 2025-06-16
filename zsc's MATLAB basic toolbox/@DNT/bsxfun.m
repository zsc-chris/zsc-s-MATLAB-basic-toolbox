function C=bsxfun(fun,A,B)
%BSXFUN	singleton expansion function for DNT
%	C=BSXFUN(fun,A,B) returns DNT(fun(gather(A),gather(B))) after automatic
%	broadcasting. Since feval is sufficient, this function is useless.
%
%	See also bsxfun, DNT/feval

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		fun(1,1)function_handle
		A DNT
		B DNT
	end
	arguments(Output)
		C DNT
	end
	C=feval(fun,A,B);
end