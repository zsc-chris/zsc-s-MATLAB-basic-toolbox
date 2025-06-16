function ret=createArray(~,~)
%DNT.createArray	Create an array of a specified size and class
%	DNT.createArray(~,~) is not supported for DNT
%	createArray(dims/*dims,"DNT",*,FillValue=0) is not supported for DNT
%
%	See also createArray, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		~
		~
	end
	arguments(Output)
		ret DNT
	end
	error("ZSC:DNT:createArray:notSupported","createArray is not supported for DNT. Use repmat instead.")
end