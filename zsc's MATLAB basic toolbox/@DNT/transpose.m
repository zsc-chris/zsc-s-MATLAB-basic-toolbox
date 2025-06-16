function ret=transpose(self,dims,finalize)
%.'	Transpose of DNT
%	ret=self.'
%	ret=TRANSPOSE(self,dims=[1,2],finalize=true) is a special case of
%	permute where only two dimensions are swapped. The value will be
%	returned if finalize==true, which allows one to directly feed the
%	output to function that only accepts a certain sequence of dimension in
%	input.
%
%	Note: Normally one does not need to do this. This is reserved for
%	forwarding this to next step of calculation.
%
%	Example:
%	>> TRANSPOSE(DNT([1,2;3,4],["a","b"]),["a","c"],false)
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
%	See also transpose, DNT, DNT/permute

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=[1,2]
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	dims=parsedims(self.dimnames,dims);
	zsc.assert(numel(dims)==2,"ZSC:DNT:multipleDimensions","Two and only two dimensions must be specified.")
	self.dimnames=[self.dimnames,setdiff(dims,self.dimnames)];
	newdims=paddata(self.dimnames,max(DNT.index(self.dimnames,dims)),FillValue=string(missing));
	newdims(DNT.index(self.dimnames,dims))=newdims(flip(DNT.index(self.dimnames,dims)));
	ret=permute(self,newdims,finalize);
end