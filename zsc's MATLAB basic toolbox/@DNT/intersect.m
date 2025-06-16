function [ret,ia,ib]=intersect(self,other,dims,setOrder)
%INTERSECT	Set intersect for DNT data
%	[ret,ia,ib]=INTERSECT(self,other,
%	dims=union(self.dimnames,other.dimnames),setOrder="sorted") intersects
%	along dims. Other dimensions are seen as a whole ("row" mode).
%
%	Example:
%	>> [ret,ia,ib]=INTERSECT(DNT([1,2;3,4],["a","b"]),DNT([1,2;3,5],["a","b"]),"a")
%
%	ret =
%
%	  1×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%
%
%	ia =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              1
%
%
%	ib =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              1
%
%	See also intersect, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		setOrder(1,1)string{mustBeMember(setOrder,["sorted","stable"])}="sorted"
	end
	arguments(Output)
		ret DNT
		ia DNT
		ib DNT
	end
	[ret,ia,ib]=fevalalong(@intersect,dims,self,other,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={"rows",setOrder});
end