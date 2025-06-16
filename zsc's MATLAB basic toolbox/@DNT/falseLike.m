function ret=falseLike(self,sz)
%falseLike	falseLike DNT
%	ret=falseLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=false(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> falseLike(DNT(gpuArray(false)),[3,2],["a","b"])
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	>> false(a=3,b=2,like=DNT(gpuArray(false)))
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%	    3              0    0
%
%	See also false, DNT, DNT/false
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
	ret=constructor(false(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end