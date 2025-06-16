function [ret,IA,IC]=uniquetol(self,tol,dims,occurence,options)
%UNIQUETOL	Set unique within a tolerance
%	[ret,IA,IC]=UNIQUETOL(self,tol=[],dims=self.dimnames,
%	occurence="lowest",*,DataScale=1,PreserveRange=false) find
%	unique values along dims. Other dimensions are seen as a whole
%	(ByRows==true).
%
%	Note: Currently OutputAllIndices and PreserveRange is not supported due
%	to a MATLAB bug.
%
%	Example:
%	>> [ret,ia,ic]=UNIQUETOL(DNT([1,2;3,4;1+eps,2-eps],["a","b"]),[],"a")
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
%	See also uniquetol, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT{mustBeFloat}
		tol double{mustBeTrue("@(tol)isscalar(tol)&&tol>0||isequal(tol,[])",tol,VariableNames="tol")}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		occurence(1,1)string{mustBeMember(occurence,["lowest","highest"])}="lowest"
		% options.OutputAllIndices(1,1)logical=false
		options.DataScale DNT=1
		% options.PreserveRange(1,1)logical=false
	end
	arguments(Output)
		ret DNT
		IA DNT
		IC DNT
	end
	% constructor=str2func(class(self));
	dims=parsedims(self.dimnames,dims);
	if isequal(tol,[])
		tol=ternary(isUnderlyingType(self,"double"),1e-12,1e-6);
	end
	[ret,IA,IC]=fevalalong(@(self,DataScale)uniquetol(self,tol,occurence,ByRows=true,DataScale=DataScale),dims,self,options.DataScale,Mode="flattenall",KeepDims=true,Unflatten=[false,false,true],KeepOtherDims=[true,false],UnflattenOther=[1,0],BroadcastSizeDims="other");%,OutputAllIndices=options.OutputAllIndices,PreserveRange=options.PreserveRange
	% if options.OutputAllIndices
	% 	IA=cellfun(@(x)constructor(x,DNT.catdims(dims)),IA,UniformOutput=false);
	% end
end