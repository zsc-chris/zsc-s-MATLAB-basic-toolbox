function ret=isvalid(self)
%ISVALID	Test handle validity in DNT
%	ret=ISVALID(self)
%
%	See also isvalid, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@isvalid,self);
end