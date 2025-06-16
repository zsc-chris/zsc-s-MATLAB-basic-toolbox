function dimnames=splitdim(dimname,n)
%DNT.splitdim	Split dimension name
%	dimnames=DNT.splitdim(dimname,n=ternary(ismissing(dimname),
%	0,count(dimname,"×")+1)) splits dimname to n dimnames.
%
%	Example:
%	>> DNT.splitdim("a×b")
%
%	ans =
%
%	  1×2 string array
%
%	    "a"    "b"
%
%	>> DNT.splitdim("a×b",3)
%
%	ans =
%
%	  1×3 string array
%
%	    "a"    "b"    "x''"
%
%	>> DNT.splitdim(missing)
%
%	ans =
%
%	  1×0 empty string array
%
%	>> DNT.splitdim(missing,3)
%
%	ans =
%
%	  1×3 string array
%
%	    "x"    "x'"    "x''"
%
%	See also DNT.catdims, DNT.gennewdims, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		dimname(1,1)string
		n(1,1)double=ternary(ismissing(dimname),0,count(dimname,"×")+1)
	end
	arguments(Output)
		dimnames(1,:)string
	end
	if ismissing(dimname)
		dimnames=DNT.gennewdims(1:n);
	else
		dimnames=split(dimname,"×")';
		if numel(dimnames)>n
			dimnames(n)=DNT.catdims(dimnames(n:numel(dimnames)));
			dimnames(n+1:end)=[];
		else
			dimnames=[dimnames,DNT.gennewdims(numel(dimnames)+1:n)];
		end
	end
end