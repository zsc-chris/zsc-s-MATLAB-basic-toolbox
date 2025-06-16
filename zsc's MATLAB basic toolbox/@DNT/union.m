function [ret,ia,ib]=union(self,other,dims,setOrder)
%UNION	Set union for DNT data
%	[ret,ia,ib]=UNION(self,other,dims=union(self.dimnames,other.dimnames),
%	setOrder="sorted") unions along dims. Other dimensions are seen as a
%	whole ("row" mode).
%
%	Example:
%	>> [ret,ia,ib]=UNION(DNT([1,2;3,4],["a","b"]),DNT([1,2;3,5],["a","b"]),"a")
%
%	ret =
%
%	  3×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%	    3              3    5
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
%	ib =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              2
%
%	See also union, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
		setOrder(1,1)string{mustBeMember(setOrder,["sorted","stable"])}="sorted"
	end
	arguments(Output)
		ret DNT
		ia DNT
		ib DNT
	end
	[ret,ia,ib]=fevalalong(@union,dims,self,other,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={"rows",setOrder});
end