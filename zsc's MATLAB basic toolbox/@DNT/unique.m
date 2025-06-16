function [ret,ia,ic]=unique(self,dims,setOrder)
%UNIQUE	Set unique for DNT data
%	[ret,ia,ic]=UNIQUE(self,dims=self.dimnames,setOrder="sorted") find
%	unique values along dims. Other dimensions are seen as a whole ("row"
%	mode).
%
%	Example:
%	>> [ret,ia,ic]=UNIQUE(DNT([1,2;3,4;1,2],["a","b"]),"a")
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ia =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              2
%
%
%	ic =
%
%	  3 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              2
%	    3              1
%
%	See also unique, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		setOrder(1,1)string{mustBeMember(setOrder,["sorted","stable","first","last"])}="sorted"
	end
	arguments(Output)
		ret DNT
		ia DNT
		ic DNT
	end
	[ret,ia,ic]=fevalalong(@unique,dims,self,Mode="flattenall",KeepDims=true,Unflatten=[false,false,true],KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={"rows",setOrder});
end