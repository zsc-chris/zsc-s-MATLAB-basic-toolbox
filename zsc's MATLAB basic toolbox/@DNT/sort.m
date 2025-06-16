function [ret,I]=sort(self,dims,direction,options)
%SORT	Sort DNT in ascending or descending order
%	[ret,I]=SORT(self,dims=self.dimnames,direction="ascend",*,
%	MissingPlacement="auto",ComparisonMethod="auto") transforms self along
%	dims by @SORT.
%
%	Note: A new dimension will be selected if dims is empty.
%
%	Example:
%	>> SORT(DNT([4,3;2,1],["a","b"]),"a")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              2    1
%	    2              4    3
%
%	>> SORT(DNT([4,3;2,1],["a","b"]),"b")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    4
%	    2              1    2
%
%	>> SORT(DNT([4,3;2,1],["a","b"]),["a","b"])
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a                    
%
%	    1              1    3
%	    2              2    4
%
%	>> SORT(DNT([4,3;2,1],["a","b"]),[])
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',x''=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              4    3
%	    2              2    1
%
%	>> SORT(DNT([4,3;2,1],["a","b"]),"c")
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              4    3
%	    2              2    1
%
%	See also sort, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		direction(1,1)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret DNT
		I DNT
	end
	dstar=dstarclass;
	[ret,I]=fevalalong(@sort,dims,self,Mode="flatten",KeepDims=true,Unflatten=1,AdditionalInput={direction,dstar{options}});
end