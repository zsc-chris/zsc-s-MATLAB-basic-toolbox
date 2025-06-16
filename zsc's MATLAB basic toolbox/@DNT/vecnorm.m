function ret=vecnorm(self,p,dims)
%VECNORM	Vector norm
%	ret=VECNORM(self,p,dims) is the same as ret=norm(self,p,dims).
%
%	See also DNT/norm, vecnorm, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		p(1,1)double=2
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	ret=norm(self,p,dims);
end