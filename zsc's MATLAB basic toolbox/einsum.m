function ret=einsum(s,tensors,options)
%EINSUM	Einstein summation
%	ret=EINSUM(s,*tensors,Finalize=all(~cellfun(@isDNT,tensors))) inputs a
%	summation instruction s like "ij,kl->il" and times the subsequent DNTs
%	(or ordinary tensors) using the index before -> and reduce each index
%	not presented after ->. Only length-1 dimension name is supported. This
%	is an implementation of numpy.einsum in matlab with support for trace,
%	i.e., "ii->i" or "ii->". ~ can be used to refer to existing dimension
%	in a DNT.
%
%	Example:
%	>> EINSUM("~~,~~->ca",DNT([1,2;3,4],["a","b"]),DNT([5,6;7,8],["b","c"]))
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         c          1     2
%	    a
%
%	    1              19    22
%	    2              43    50
%
%	>> EINSUM("aa->a",[1,2;3,4])
%
%	ans =
%
%	     1
%	     4
%
%	>> EINSUM("aa->",[1,2;3,4])
%
%	ans =
%
%	     5
%
%	See also trace, mtimes, pagemtimes, tensorprod, DNT

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		s(1,1)string="->"
	end
	arguments(Input,Repeating)
		tensors
	end
	arguments(Input)
		options.Finalize(1,1)logical=all(~cellfun(@isDNT,tensors))
	end
	arguments(Output)
		ret
	end
	dimss=strtrim(s.split([",","->"])');
	inputs=dimss(1:end-1);
	outputs=dimss(end);
	zsc.assert(numel(inputs)==numel(tensors),"ZSC:einsum:inputNotMatched","Input is not matched with instruction.")
	zsc.assert(numel(sort(char(outputs)))==numel(unique(char(outputs))),"ZSC:einsum:outputNotUnique","Output dimension is not unique.")
	for i=1:numel(tensors)
		dims=string(num2cell(char(inputs(i))));
		if isDNT(tensors{i})
			dims(dims=="~")=tensors{i}.dimnames(dims=="~");
			tensors{i}=DNT(tensors{i},dims);
		else
			zsc.assert(~ismember("~",dims),"ZSC:einsum:nothingToFill","Cannot fill in dimensions for non-DNT input.")
			tensors{i}=DNT(tensors{i},dims);
		end
	end
	ret=tensors{1};
	for i=2:numel(tensors)
		ret=ret.*tensors{i};
	end
	newdims=string(num2cell(char(outputs)));
	ret=sum(ret,setdiff(ret.dimnames,newdims));
	if options.Finalize
		ret=permute(ret,newdims);
	end
end