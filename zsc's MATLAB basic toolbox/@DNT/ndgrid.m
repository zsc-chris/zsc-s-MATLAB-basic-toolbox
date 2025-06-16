function DNTs=ndgrid(DNTs)
%NDGRID	Generate DNTs for N-D functions and interpolation
%	*DNTs=NDGRID(DNT/*DNTs) is the same as *DNTs=feval(@deal,*DNTs) except
%	for single DNT input, where DNT will be repeated nargout times with
%	each subsequent DNT adding a prime in dimnames.
%
%	Note: This is usually unnecessary, since DNT supports both mgrid
%	(ndgrid, not meshgrid, despite the name) and ogrid.
%
%	Example:
%	>> [a,a_prime]=NDGRID(DNT(1:2,"a"))
%
%	a =
%
%	  2×2 DNT double matrix
%
%	          a'          1    2
%	     a
%
%	     1                1    1
%	     2                2    2
%
%
%	a_prime =
%
%	  2×2 DNT double matrix
%
%	          a'          1    2
%	     a
%
%	     1                1    2
%	     2                1    2
%
%	>> [a,b]=NDGRID(DNT(1:2,"a"),DNT(1:2,"b"))
%
%	a =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              2    2
%
%
%	b =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              1    2
%
%	See also ndgrid, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	if nargin==1
		DNTs=repmat(DNTs,[1,nargout]);
		for i=2:nargout
			DNTs{i}.dimnames=DNTs{i}.dimnames+extractAfter(DNT.gennewdims(i),1);
		end
	end
	[DNTs{:}]=feval(@deal,DNTs{:});
end