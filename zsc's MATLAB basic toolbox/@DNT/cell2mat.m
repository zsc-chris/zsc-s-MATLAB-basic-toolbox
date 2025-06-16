function ret=cell2mat(self,dims,finalize)
%cell2mat	Convert the contents of a cell array into a single tensor
%	ret=cell2mat(self,dims=self.dimnames,finalize=true) concatenates self
%	along dims, and remove cell layer if all dimensions are selected and
%	finalize==true.
%
%	Example:
%	>> cell2mat(DNT({DNT([1,2],"a");DNT([1,2],"b")},"a"),"a")
%
%	ans =
%
%	  3×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    1
%	    2              2    2
%	    3              1    2
%
%	See also zsc.cell2mat

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT{mustBeUnderlyingType(self,"cell")}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	dims=parsedims(self.dimnames,dims);
	self=cellfun(@DNT,self,UniformOutput=false);
	ret=fevalalong(@cell2mat_,dims,self,AdditionalInput={dims});
	if all(ismember(self.dimnames,sort(dims)))&&finalize
		ret=gather(ret);
		ret=ret{1};
	end
end
function self=cell2mat_(self,dims,dimnames)
	for i=1:numel(dimnames)
		self=num2cell(self,dims(i));
		self=cellfun(@(x)cat(dimnames(i),x{:}),self,UniformOutput=false);
	end
end