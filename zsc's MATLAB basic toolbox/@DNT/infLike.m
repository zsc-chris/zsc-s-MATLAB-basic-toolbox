function ret=infLike(self,sz)
%infLike	infLike DNT
%	ret=infLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=inf(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> infLike(gpuArray(single(DNT)),[3,2],["a","b"])
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b           1      2
%	    a
%
%	    1              Inf    Inf
%	    2              Inf    Inf
%	    3              Inf    Inf
%
%	>> inf(a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b           1      2
%	    a
%
%	    1              Inf    Inf
%	    2              Inf    Inf
%	    3              Inf    Inf
%
%	See also inf, DNT, DNT/inf
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
	ret=constructor(inf(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end