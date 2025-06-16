function [ret,ia,ib]=setxor(self,other,dims,setOrder)
%SETXOR	Set setxor for DNT data
%	[ret,ia,ib]=SETXOR(self,other,dims=union(self.dimnames,other.dimnames),
%	setOrder="sorted") setxors along dims. Other dimensions are seen as a
%	whole ("row" mode).
%
%	Example:
%	>> [ret,ia,ib]=SETXOR(DNT([1,2;3,4],["a","b"]),DNT([1,2;3,5],["a","b"]),"a")
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    4
%	    2              3    5
%
%
%	ia =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              2
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
%	See also setxor, DNT

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
	[ret,ia,ib]=fevalalong(@setxor,dims,self,other,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={"rows",setOrder});
end