function ret=compactRepresentationForColumn(self,~,~)
%compactRepresentationForColumn	Columnar display representation of an
%object
%	ret=compactRepresentationForColumn(self,~,~)
%
%	See also compactRepresentationForColumn

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		~
		~
	end
	cls=string(class(self));
	constructor=str2func(cls);
	dimstring=matlab.internal.display.dimensionString(subsref(self,substruct("()",{self.dimnames(1),constructor(1,self.dimnames(1))})));
	ret=CompactDisplayRepresentation(repmat(dimstring+" "+cls,size(self,1),1),repmat(strlength(dimstring+" "+cls),size(self,1),1),repmat(dimstring+" "+cls,size(self,1),1));
end