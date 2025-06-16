function ret=trueLike(self,sz)
%trueLike	trueLike DNT
%	ret=trueLike(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
%	ret=true(sz/(sz,dims)/*sz/**sz/mapping(**sz),like=self)
%
%	Example:
%	>> trueLike(DNT(gpuArray(false)),[3,2],["a","b"])
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%	    3              1    1
%
%	>> true(a=3,b=2,like=DNT(gpuArray(false)))
%
%	ans =
%
%	  2×2 DNT gpuArray logical matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              1    1
%	    3              1    1
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
	ret=constructor(true(paddata(zsc.cell2mat(sz(2,:)),[1,2],FillValue=1),like=gather(self)),zsc.cell2mat(sz(1,:)));
end