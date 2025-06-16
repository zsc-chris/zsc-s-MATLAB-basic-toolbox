function ret=randiLike(self,varargin)
%randiLike	randiLike DNT
%	ret=randiLike(self[,s],irange,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=randi([s,]irange,sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> gpurng default
%	>> randiLike(gpuArray(single(DNT)),5,[3,2],["a","b"])
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              2    4
%	    2              3    1
%	    3              4    5
%
%	>> randi(5,a=3,b=2,like=gpuArray(single(DNT)))
%
%	ans =
%
%	  3×2 DNT gpuArray single matrix
%
%	         b         1    2
%	    a
%
%	    1              4    3
%	    2              2    1
%	    3              1    5
%
%	See also randi, DNT, DNT/randi
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
	zsc.assert(~isempty(varargin),message("MATLAB:minrhs"))
	irange=varargin{1};
	sz=varargin(2:end);
	sz=parsedimargs(self.dimnames,sz);
	zsc.assert(isempty(sz)||isequaln(sort(zsc.cell2mat(sz(1,:))),unique(zsc.cell2mat(sz(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=constructor(randi(s{:},irange,paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end