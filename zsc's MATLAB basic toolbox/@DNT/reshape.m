function ret=reshape(self,sz)
%RESHAPE	Change size of DNT
%	ret=RESHAPE(self,sz/(sz,dims)/*sz/**sz/mapping(**sz)) returns
%	a new DNT whose size is sz and whose data flattens to
%	flatten(gather(self)).
%
%	Example:
%	>> RESHAPE(DNT([1,2;3,4]),a=1,b=4,c=1)
%
%	  1×4×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2    3    4
%	    a
%
%	    1              1    3    2    4
%
%	See also reshape

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		sz(1,:)
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	sz=parsedimargs(self.dimnames,sz);
	zsc.assert(isempty(sz)||isequaln(sort(zsc.cell2mat(sz(1,:))),unique(zsc.cell2mat(sz(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=constructor(zsc.reshape(gather(self),zsc.cell2mat(sz(2,:))),zsc.cell2mat(sz(1,:)));
end