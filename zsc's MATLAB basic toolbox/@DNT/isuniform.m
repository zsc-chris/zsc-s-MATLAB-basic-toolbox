function [ret,step]=isuniform(self,dims)
%ISUNIFORM	Check if data is uniformly spaced
%	[ret,step]=ISUNIFORM(self,dims=self.dimnames) checks if self's data
%	forms a hyperplane along dims. step is in the form of struct(**step).
%	All results are reduced/squeezed in dimensions.
%
%	Example:
%	>> [ret,step]=ISUNIFORM(cat("c",DNT([1,2;3,4],["a","b"]),DNT([5,6;7,9],["a","b"])),["a","b"])
%
%	ret =
%
%	  2 DNT logical vector
%
%
%	    c
%
%	    1              1
%	    2              0
%
%
%	step =
%
%	  struct with fields:
%
%	    a: [2 DNT]
%	    b: [2 DNT]
%
%	>> step.a
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    c
%
%	    1                2
%	    2              NaN
%
%	>> step.b
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    c
%
%	    1                1
%	    2              NaN
%
%	See also isuniform, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
		step(1,1)struct
	end
	constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	ret=constructor(true(paddata(size(self),2,FillValue=1)),self.dimnames);
	ret.dimnames(DNT.index(ret.dimnames,dims))=missing;
	step=struct();
	for i=dims
		[reti,sizei]=fevalalong(@isuniform,i,self,Vectorized=false);
		reti=all(reti,dims(dims~=i));
		isuniformi=fevalalong(@(self)isscalar(uniquetol(self,4*eps)),dims(dims~=i),sizei,Mode="flatten",BroadcastSizeDims="other",Vectorized=false);
		ret=ret&reti&isuniformi;
		step.(i)=mean(sizei,dims(dims~=i));
		step.(i).data(~gather(isuniformi))=nan;
	end
end