function [ret,LocB]=ismembertol(self,other,tol,dims,options)
%ISMEMBERTOL	Set ismember within a tolerance
%	[ret,LocB]=ISMEMBERTOL(self,other,tol=[],
%	dims=union(self.dimnames,other.dimnames),*,OutputAllIndices=false,
%	DataScale=1) find unique values along dims. Other dimensions are seen
%	as a whole (ByRows==true).
%
%	Example:
%	>> [ret,LocB]=ISMEMBERTOL(DNT([1+eps,2-eps;3,4;5,6],["a","b"]),DNT([1,2;3,4;1,2],["a","b"]),[],"a")
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
%	See also uniquetol, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT{mustBeFloat}
		other DNT{mustBeFloat}
		tol double{mustBeTrue("@(tol)isscalar(tol)&&tol>0||isequal(tol,[])",tol,VariableNames="tol")}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
		options.OutputAllIndices(1,1)logical=false
		options.DataScale DNT=1
	end
	arguments(Output)
		ret DNT
		LocB DNT
	end
	constructor=str2func(class(self));
	dims=parsedims(union(self.dimnames,other.dimnames),dims);
	if isequal(tol,[])
		tol=ternary(isUnderlyingType(self,"double"),1e-12,1e-6);
	end
	[ret,LocB]=fevalalong(@(self,other,DataScale)ismembertol(self,other,tol,OutputAllIndices=options.OutputAllIndices,ByRows=true,DataScale=DataScale),dims,self,other,options.DataScale,Mode="flattenall",KeepDims=true,Unflatten=1,BroadcastSizeDims="other");
	if options.OutputAllIndices
		LocB=cellfun(@(x)constructor(x,DNT.catdims(dims)),LocB,UniformOutput=false);
	end
end