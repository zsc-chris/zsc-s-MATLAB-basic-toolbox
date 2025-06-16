function ret=onesLike(self,sz)
%onesLike	onesLike DNT
%	ret=onesLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=ones(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> onesLike(gpuArray(single(DNT)),[3,2],["a","b"])
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%	    3              1    1
%
%	>> ones(a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%	    3              1    1
%
%	See also ones, DNT, DNT/ones
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
	ret=constructor(ones(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end