function ret=repelem(self,r)
%REPELEM	Replicate elements of an array
%	ret=REPELEM(self,[*r|**r])
%
%	Note: Original repelem does not support 2 argument syntax for matrix
%	input, but this repelem will assign the second argument to the first
%	dimension in case of 2 argument syntax. To specify argument for each
%	dimension, use name-value syntax.
%
%	Example:
%	>> REPELEM(DNT([1,2;3,4],["a","b"]),a=[1,2],c=2)
%
%	  3×2×2 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%	    3              3    4
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%	    3              3    4
%
%	See also repelem, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		r(1,:)
	end
	arguments(Output)
		ret DNT
	end
	r=parsedimargs(self.dimnames,r,false);
	zsc.assert(isempty(r)||isequaln(sort(zsc.cell2mat(r(1,:))),unique(zsc.cell2mat(r(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	if isempty(r)
		ret=self;
		return
	end
	self.dimnames(DNT.index(self.dimnames,zsc.cell2mat(r(1,:))))=zsc.cell2mat(r(1,:));
	dict=dictionary(zsc.cell2mat(r(1,:)),r(2,:));
	r=paddata(lookup(dict,self.dimnames,FallbackValue={1}),2,FillValue={1});
	ret=feval(@repelem,self,additionalinput=r);
end