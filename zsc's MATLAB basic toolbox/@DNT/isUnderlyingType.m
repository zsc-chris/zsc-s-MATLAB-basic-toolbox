function ret=isUnderlyingType(self,classname)
%isUnderlyingType	Determine if a DNT has the specified underlying type
%	ret=isUnderlyingType(self,classname) returns true if the underlying
%	type of self is equal to classname, as returned by
%	underlyingType(self). Otherwise, the result is FALSE. classname must be
%	a character vector or string scalar.
%
%	See also underlyingType, mustBeUnderlyingType, class, DNT
	arguments(Input)
		self DNT
		classname(1,1)string
	end
	arguments(Output)
		ret logical
	end
	ret=isUnderlyingType(gather(self),classname);
end