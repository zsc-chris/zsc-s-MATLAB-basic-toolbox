function [ret,index]=sortrows(self,dims,column,direction,options)
%SORTROWS	Sort rows of DNT in ascending order
%	[ret,index]=SORTROWS(self,dims=self.dimnames,
%	column=1:numel(self)/end_(self,dims),direction="ascend",*,
%	MissingPlacement="auto",ComparisonMethod="auto") sorts along dims
%	according to column as precedence. Other dimensions are seen as a
%	whole.
%
%	Example:
%	>> [ret,index]=SORTROWS(DNT([2,4;3,2;1,4],["a","b"]),"a",2)
%
%	ret =
%
%	  3×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    2
%	    2              2    4
%	    3              1    4
%
%
%	index =
%
%	  3 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              1
%	    3              3
%
%	>> [ret,index]=SORTROWS(DNT([2,4;3,2;1,4],["a","b"]),"a",[2,1])
%
%	ret =
%
%	  3×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    2
%	    2              1    4
%	    3              2    4
%
%
%	index =
%
%	  3 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              3
%	    3              1
%
%	See also sortrows, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		column(1,:)double=1:numel(self)/end_(self,dims)
		direction(1,:)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret DNT
		index DNT
	end
	dstar=dstarclass;
	[ret,index]=fevalalong(@sortrows,dims,self,Mode="flattenall",KeepDims=true,Unflatten=1,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={column,direction,dstar{options}});
end