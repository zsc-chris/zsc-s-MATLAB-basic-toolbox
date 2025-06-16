function ret=zerosLike(self,sz)
%zerosLike	zerosLike DNT
%	ret=zerosLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=zeros(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> zerosLike(gpuArray(single(DNT)),[3,2],["a","b"])
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	>> zeros(a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	See also zeros, DNT, DNT/zeros
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
	ret=constructor(zeros(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end