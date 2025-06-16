function ret=nanLike(self,sz)
%nanLike	Build DNT containing Not-a-number
%	ret=nanLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=nan(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> nanLike(gpuArray(single(DNT)),[3,2],["a","b"])
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b           1      2
%	    a
%
%	    1              NaN    NaN
%	    2              NaN    NaN
%	    3              NaN    NaN
%
%	>> nan(a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  2×2 DNT gpuArray single matrix
%
%	         b           1      2
%	    a
%
%	    1              NaN    NaN
%	    2              NaN    NaN
%	    3              NaN    NaN
%
%	See also nan, DNT, DNT/nan
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
	ret=constructor(nan(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end