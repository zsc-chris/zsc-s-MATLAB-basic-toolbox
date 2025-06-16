function ret=repmat(self,r)
%REPMAT	Replicate and tile a DNT
%	ret=REPMAT(self,r/(r,dims)/*r/**r/mapping(**r)) creates a large DNT ret
%	consisting of an r tiling of copies of self.
%
%	Example:
%	>> REPMAT(DNT([1,2;3,4],["a","b"]),a=2,c=2)
%
%	  4×2×2 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%	    3              1    2
%	    4              3    4
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%	    3              1    2
%	    4              3    4
%
%	See also repmat, DNT

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
	r=parsedimargs(self.dimnames,r);
	zsc.assert(isempty(r)||isequaln(sort(zsc.cell2mat(r(1,:))),unique(zsc.cell2mat(r(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	self.dimnames(DNT.index(self.dimnames,zsc.cell2mat(r(1,:))))=zsc.cell2mat(r(1,:));
	dict=dictionary(zsc.cell2mat(r(1,:)),r(2,:));
	r=lookup(dict,self.dimnames,FallbackValue={1});
	ret=feval(@repmat,self,additionalinput=r);
end