function ret=dot(self,other,dims)
%DOT	Vector dot product of DNT
%	ret=DOT(self,other,dims=union(self.dimnames,other.dimnames)) returns
%	the dot product of the vectors along dims of self and other.
%
%	See also dot, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
	end
	ret=fevalalong(@dot,dims,self,other,Mode="flatten")
end