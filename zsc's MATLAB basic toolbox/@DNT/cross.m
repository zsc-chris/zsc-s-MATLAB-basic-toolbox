function ret=cross(self,other,dim)
%CROSS	Vector cross product of DNTs
%	ret=CROSS(self,other,dim=1) returns the cross product of the vectors
%	along dim of self and other. size(A,dim) and size(B,dim) should
%	broadcast to 3.
%
%	See also cross, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
		dim(1,:){mustBeA(dim,["logical","numeric","string","char","cell","missing"])}=1
	end
	dim=parsedims(union(self.dimnames,other.dimnames),dim);
	zsc.assert(isscalar(dim),"ZSC:DNT:multipleDimensions","One and only one dimension must be specified.")
	ret=fevalalong(@cross,dim,self,other);
end