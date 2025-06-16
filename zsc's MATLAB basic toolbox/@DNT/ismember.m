function [ret,Locb]=ismember(self,other,dims)
%ISMEMBER	True for member of DNT set
%	[ret,LocB]=ISMEMBER(self,other,
%	dims=union(self.dimnames,other.dimnames))
%
%	Example:
%	>> [ret,LocB]=ISMEMBER(DNT([1,2;3,4;5,6],["a","b"]),DNT([1,2;3,4;1,2],["a","b"]),"a")
%
%	ret =
%
%	  3 DNT logical vector
%
%
%	    a
%
%	    1              1
%	    2              1
%	    3              0
%
%
%	LocB =
%
%	  3 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              2
%	    3              0
%
%	See also ismember, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
	end
	arguments(Output)
		ret DNT
		Locb DNT
	end
	[ret,Locb]=fevalalong(@zsc.ismember,dims,self,other,Mode="flattenall",KeepDims=true,Unflatten=1,AdditionalInput={"rows"});
end