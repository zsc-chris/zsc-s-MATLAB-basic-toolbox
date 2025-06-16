function ret=linspace(self,other,n,dim,options)
%LINSPACE	Linspace DNT
%	ret=LINSPACE(self,other,n=50,dim="x",*,Precise=true) interpolates self
%	to other by n segments along dim. Faster but imprecise algorithm is
%	used if Precise==false.
%
%	Example:
%	>> LINSPACE(DNT(1),DNT(5),5)
%
%	ans =
%
%	  5 DNT double vector
%
%
%	    x
%
%	    1              1
%	    2              2
%	    3              3
%	    4              4
%	    5              5
%
%	>> LINSPACE(DNT([1,2;3,4],["a","b"]),DNT([4,3;2,1],["a","b"]),3,"c")
%
%	  2×2×3 DNT double tensor
%
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ans(a=':',b=':',c=2).squeeze(3) =
%
%	         b              1         2
%	    a
%
%	    1              2.5000    2.5000
%	    2              2.5000    2.5000
%
%
%	ans(a=':',b=':',c=3).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              4    3
%	    2              2    1
%
%	See also linspace, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		n(1,1)double{mustBeInteger,mustBePositive}=50
		dim(1,1)string="x"
	end
	arguments(Input)
		options.Precise=true
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	if options.Precise
		ret=fevalalong(@(x,y,n)linspace(x,y,n)',dim,self,other,KeepDims=true,Vectorized=false,AdditionalInput={n});
	else
		tmp=constructor(linspace(0,1,n),dim);
		ret=self.*flip(tmp)+other.*tmp;
	end
end