function ret=diff(self,n,dims)
%DIFF	Difference and approximate derivative
%	ret=DIFF(self,n=[],dims=self.dimnames) transforms self along dims by @DIFF.
%
%	See also diff, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		n{mustBeInteger,mustBePositive,mustBeTrue("@(n)isscalar(n)||isequal(n,[])",n,VariableNames="n")}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
	end
	if isequal(n,[])
		n=1;
	end
	ret=fevalalong(@(x,dim)diff(x,n,dim),dims,self,Mode="iterate",KeepDims=true);
end