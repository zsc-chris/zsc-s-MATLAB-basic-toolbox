function ret=randLike(self,varargin)
%randLike	randLike DNT
%	ret=randLike(self[,s],sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=rand([s,]sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> gpurng default
%	>> randLike(gpuArray(single(DNT)),[3,2],["a","b"])
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b              1         2
%	    a
%
%	    1              0.3640    0.7436
%	    2              0.5421    0.0342
%	    3              0.6543    0.8311
%
%	>> rand(a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b              1         2
%	    a
%
%	    1              0.7040    0.5671
%	    2              0.2817    0.1726
%	    3              0.1163    0.9207
%
%	See also rand, DNT, DNT/rand
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
	ret=constructor(rand(s{:},paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end