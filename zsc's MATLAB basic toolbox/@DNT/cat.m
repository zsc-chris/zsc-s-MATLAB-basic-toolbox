function ret=cat(dim,DNTs)
%CAT	Concatenate DNTs
%	ret=CAT(dim,*DNTs)
%
%	Example:
%	>> CAT("a",DNT([1,2],"a"),DNT([1,2],"b"))
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
%	See also cat, DNT/vertcat, DNT/horzcat

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		dim(1,:){mustBeA(dim,["logical","numeric","string","char","cell","missing"])}
	end
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Output)
		ret DNT
	end
	star=starclass;
	dim=parsedims(unique([star{DNTs,2}{1}.dimnames]),dim);
	zsc.assert(isscalar(dim),"ZSC:DNT:multipleDimensions","One and only one dimension must be specified.")
	ret=fevalalong(@(varargin)cat(varargin{end},varargin{1:end-1}),dim,DNTs{:},KeepDims=true,BroadcastSizeDims="other");
end