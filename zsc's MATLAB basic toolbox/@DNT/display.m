function display(self,objName)
%DISPLAY	Display DNT
%	DISPLAY(self,objName=inputname(1))
%
%	See also display, DNT, DNT/disp

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		objName(1,:)char=subsref(str2func("inputname"),substruct("()",{1}));
	end
	dispInternal(self,objName)
end