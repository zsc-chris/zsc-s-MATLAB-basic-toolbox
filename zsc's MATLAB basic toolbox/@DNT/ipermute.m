function ret=ipermute(self,dims,finalize)
%IPERMUTE	Inversely permute dimensions' names of DNT
%	ret=IPERMUTE(self,dims,finalize=true) returns a permuted DNT where the
%	dimensions are inversely permuted from the original dims. The value
%	will be returned if finalize==true, which allows one to directly feed
%	the output to function that only accepts a certain sequence of
%	dimension in input.
%
%	Note: Normally you don't need to do this. This is reserved for
%	forwarding this to next step of calculation.
%
%	Example:
%	>> IPERMUTE(DNT([1,2;3,4],["a","b"]),["a","c","b"],false)
%
%	  2×1×2 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1
%	    a
%
%	    1              1
%	    2              3
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1
%	    a
%
%	    1              2
%	    2              4
%
%	See also ipermute, DNT/permute

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	zsc.assert(all(ismember(self.dimnames,dims)),message("MATLAB:permute:tooFewIndices"))
	zsc.assert(isequaln(sort(dims),unique(dims)),message("MATLAB:permute:repeatedIndex"))
	zsc.assert(all(~ismissing(dims))&&isequal(sort(DNT.index(self.dimnames,dims)),1:numel(dims)),message("MATLAB:permute:badIndex"));
	out=outclass;
	ret=constructor(zsc.ipermute(gather(self),DNT.index(self.dimnames,dims)),dims(out{2,2,@sort,DNT.index(self.dimnames,dims)}));
	if finalize
		ret=gather(ret);
	end
end