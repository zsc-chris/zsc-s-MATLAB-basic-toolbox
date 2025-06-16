function ret=randnLike(self,varargin)
%randnLike	randnLike DNT
%	ret=randnLike(self[,s],sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=randn([s,]sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> gpurng default
%	>> randnLike(gpuArray(single(DNT)),[3,2],["a","b"])
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b               1          2
%	    a
%
%	    1              -1.3724    -0.9203
%	    2              -0.3716     1.2682
%	    3              -0.0372    -2.2682
%
%	>> randn(a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b               1          2
%	    a
%
%	    1              -0.1655    -0.8487
%	    2               0.8213     1.6462
%	    3              -1.8927    -0.8962
%
%	See also randn, DNT, DNT/randn
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	if ~isempty(varargin)&&isa(varargin{1},"RandStream")
		s=varargin(1);
		sz=varargin(2:end);
	else
		s={};
		sz=varargin;
	end
	sz=parsedimargs(self.dimnames,sz);
	zsc.assert(isempty(sz)||isequaln(sort(zsc.cell2mat(sz(1,:))),unique(zsc.cell2mat(sz(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=constructor(randn(s{:},paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end