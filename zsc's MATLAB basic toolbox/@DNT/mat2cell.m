function ret=mat2cell(self,dimDist)
%mat2cell	Break tensor up into a cell array of tensors
%	ret=mat2cell(self,[*dimDist|**dimDist])
%
%	Example:
%	>> mat2cell(DNT([1,2;3,4],["a","b"]),a=[1,1],c=1)
%
%	  2×1×1 DNT cell tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b                   1
%	    a
%
%	    1              {1×2×1 DNT}
%	    2              {1×2×1 DNT}
%
%	>> ans{:}
%
%	  1×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              1    2
%
%
%	  1×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b         1    2
%	    a
%
%	    1              3    4
%
%	See also repelem, DNT/repmat
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		dimDist(1,:)
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	dimDist=parsedimargs(self.dimnames,dimDist,false);
	zsc.assert(isempty(dimDist)||all(arrayfun(@(x,y)sum(x{:})==y,dimDist(2,:),size(self,zsc.cell2mat(dimDist(1,:))))),message("MATLAB:mat2cell:VectorSumMismatch",size(dimDist,2),join(paddata(string(size(self,zsc.cell2mat(dimDist(1,:)))),1,FillValue=""),"  ")))
	if isempty(dimDist)
		ret=constructor({self},self.dimnames);
		return
	end
	self.dimnames(DNT.index(self.dimnames,zsc.cell2mat(dimDist(1,:))))=zsc.cell2mat(dimDist(1,:));
	dict=dictionary(zsc.cell2mat(dimDist(1,:)),dimDist(2,:));
	r=arrayfun(@(x,y)lookup(dict,x,FallbackValue={y}),self.dimnames,size(self));
	ret=constructor(cellfun(@(x)constructor(x,self.dimnames),mat2cell(gather(self),r{:}),UniformOutput=false),self.dimnames);
end