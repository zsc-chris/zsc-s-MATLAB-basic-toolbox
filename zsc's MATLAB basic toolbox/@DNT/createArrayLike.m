function ret=createArrayLike(~,~,~)
%createArrayLike	createArrayLike DNT
%	createArrayLike(~,~,~) is not supported for DNT
%	createArray(dims/*dims,*,like,FillValue=0) is not supported for DNT
%
%	See also createArray, DNT, DNT/createArray

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		~
		~
		~
	end
	arguments(Output)
		ret DNT
	end
	error("ZSC:DNT:createArray:notSupported","createArray is not supported for DNT. Use repmat instead.")
end