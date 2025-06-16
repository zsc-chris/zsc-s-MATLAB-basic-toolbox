function [ret,I]=topkrows(self,k,dims,col,direction,options)
%TOPKROWS	Top rows in sorted order
%	[ret,I]=TOPKROWS(self,k,dims=self.dimnames,
%	col=1:numel(self)/end_(self,dims),direction="ascend",*,
%	ComparisonMethod="auto") selects top k rows along dims according to col
%	as precedence. Other dimensions are seen as a whole.
%
%	Example:
%	>> [ret,I]=TOPKROWS(DNT([2,4;3,2;1,4],["a","b"]),2,"a",2)
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    2
%	    2              2    4
%
%
%	I =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              1
%
%	>> [ret,I]=TOPKROWS(DNT([2,4;3,2;1,4],["a","b"]),2,"a",[2,1])
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    2
%	    2              1    4
%
%
%	I =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              3
%
%	See also topkrows, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		k{mustBeInteger,mustBeNonnegative}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		col(1,:)double=1
		direction(1,:)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret DNT
		I DNT
	end
	dstar=dstarclass;
	[ret,I]=fevalalong(@topkrows,dims,self,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={k,col,direction,dstar{options}});
end