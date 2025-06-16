function [ret,ia]=setdiff(self,other,dims,setOrder)
%SETDIFF	Set difference for DNT data
%	[ret,ia]=SETDIFF(self,other,dims=union(self.dimnames,other.dimnames),
%	setOrder="sorted") setdiffs along dims. Other dimensions are seen as a
%	whole ("row" mode).
%
%	Example:
%	>> [ret,ia]=SETDIFF(DNT([1,2;3,4],["a","b"]),DNT([1,2;3,5],["a","b"]),"a")
%
%	ret =
%
%	  1×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    4
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
%	See also setdiff, DNT

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
	end
	[ret,ia]=fevalalong(@setdiff,dims,self,other,Mode="flattenall",KeepDims=true,KeepOtherDims=[true,false],UnflattenOther=[1,0],AdditionalInput={"rows",setOrder});
end