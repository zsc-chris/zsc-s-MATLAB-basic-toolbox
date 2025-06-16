function ret=ctranspose(self,dims,finalize)
%'	Complex conjugate transpose of DNT
%	ret=self'
%	ret=CTRANSPOSE(self,dims=[1,2],finalize=true) takes the conjugate of
%	transpose output if conj is available. The value will be returned if
%	finalize is true, which allows one to directly feed the output to
%	function that only accepts a certain sequence of dimension in input.
%
%	Note: Normally one does not need to do this. This is reserved for
%	forwarding this to next step of calculation.
%
%	Example:
%	>> CTRANSPOSE(DNT([1,2;3,4],["a","b"]),["a","c"],false)
%
%	  1×2×2 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              3    4
%
%	See also ctranspose, DNT, DNT/permute, DNT/transpose

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=[1,2]
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	if ismethod(underlyingType(self),"conj")
		self=conj(self);
	end
	ret=transpose(self,dims,finalize);
end