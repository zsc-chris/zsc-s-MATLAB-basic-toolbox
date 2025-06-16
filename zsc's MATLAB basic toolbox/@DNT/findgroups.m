function [ret,ID]=findgroups(DNTs,options)
%FINDGROUPS	Find groups and return group numbers
%	[ret,*ID]=findgroups(*DNTs,
%	Dimensions=unique(horzcat(DNT.dimnames for DNT in DNTs)) returns unique
%	group number of unique combinations as ret and each combination as ID
%	along Dimensions.
%
%	Example:
%	>> [ret,ID{1:2}]=FINDGROUPS(DNT([1;1;1;2],"a"),DNT(["a","b";"c","d";"a","b";"c","d"],["a","b"]),Dimensions="a")
%
%	ret =
%
%	  4 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              2
%	    3              1
%	    4              3
%
%
%	ID =
%
%	  1×2 cell array
%
%	    {3×1 DNT}    {3×2 DNT}
%
%	>> ID{:}
%
%	ans =
%
%	  3×1 DNT double matrix
%
%	         b         1
%	    a
%
%	    1              1
%	    2              1
%	    3              2
%
%
%	ans =
%
%	  3×2 DNT string matrix
%
%	         b           1      2
%	    a
%
%	    1              "a"    "b"
%	    2              "c"    "d"
%	    3              "c"    "d"
%
%	See also findgroups, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Input)
		options.Dimensions{mustBeA(options.Dimensions,["logical","numeric","string","char","cell","missing"])}
	end
	arguments(Output)
		ret DNT
	end
	arguments(Output,Repeating)
		ID DNT
	end
	if ~isfield(options,"Dimensions")
		star=starclass;
		options.Dimensions=unique([star{DNTs,2}{1}.dimnames]);
	end
	[ret,ID{1:numel(DNTs)}]=fevalalong(@findgroups_,options.Dimensions,DNTs{:},Mode="flattenall",KeepDims=true,Unflatten=[1,0],KeepOtherDims=[false,true],UnflattenOther=0:numel(DNTs),BroadcastSizeDims="");
end
function [ret,ID]=findgroups_(A)
	arguments(Input,Repeating)
		A
	end
	arguments(Output)
		ret
	end
	arguments(Output,Repeating)
		ID
	end
	sz=cumsum(cellfun(@(x)size(x,2),A));
	A=cellfun(@(x)num2cell(x,1),A,UniformOutput=false);
	A=horzcat(A{:});
	[ret,ID{1:numel(A)}]=findgroups(A{:});
	ID=arrayfun(@(i)horzcat(ID{ifinline(i==1,@()1,@()sz(i-1)+1):sz(i)}),1:numel(sz),UniformOutput=false);
end