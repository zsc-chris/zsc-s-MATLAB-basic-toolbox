function ret=munit(sz,ind,dtypes)
%MUNIT	Matrix unit/one-hot tensor
%	MUNIT(sz,ind,*dtypes)=(E_ind)_sz:=(δ_sz_ind)_sz
%	Can be multidimensional.
%
%	Example:
%	>> MUNIT([2,2],[1,2])
%
%	ans =
%
%	     0     1
%	     0     0
%
%	>> MUNIT([2,2],[2,1],"like",sparse(0))
%
%	ans =
%
%	  2×2 sparse double matrix (1 nonzero)
%
%	   (2,1)        1
%
%	See also eye, zeros, ones

%	Copyright 2023 Chris H. Zhao
	arguments(Input)
		sz(1,:)
		ind(1,:)
	end
	arguments(Input,Repeating)
		dtypes
	end
	arguments(Output)
		ret{mustBeTrue("@(ret)nnz(ret)==1",ret,varname="ret")}
	end
	ret=zeros(sz,dtypes{:});
	star=starclass;
	ret(star{ind,2})=1;
end