function ret=broadcast(self,sz)
%BROADCAST	Broadcast DNT to certain size
%	ret=BROADCAST(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	broadcasts self to sz.
%
%	Example:
%	>> BROADCAST(DNT([1,2],["a","b"]),a=2,c=2)
%
%	  2×2×2 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              1    2
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              1    2
%
%	See also bsxfun, DNT/feval

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		sz
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	sz=parsedimargs(self.dimnames,sz);
	zsc.assert(isempty(sz)||isequaln(sort(zsc.cell2mat(sz(1,:))),unique(zsc.cell2mat(sz(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	self.dimnames(DNT.index(self.dimnames,zsc.cell2mat(sz(1,:))))=zsc.cell2mat(sz(1,:));
	dict=dictionary(zsc.cell2mat(sz(1,:)),zsc.cell2mat(sz(2,:)));
	sz=arrayfun(@(x,y)lookup(dict,x,FallbackValue=y),self.dimnames,size(self));
	ret=constructor(broadcast(gather(self),sz),self.dimnames);
end