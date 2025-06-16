function ret=join(self,delimiter,dims)
%JOIN	Combine strings
%	ret=join(self,delimiter,dims=self.dimnames)
%
%	Note: Since delimiter is string, name-value arguments won't work here.
%
%	See also join, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		delimiter(1,:)string
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Output)
		ret DNT
	end
	dims=parsedims(self.dimnames,dims);
	dims=DNT.index(self.dimnames,dims);
	if isscalar(delimiter)
		delimiter=repmat(delimiter,[1,numel(dims)]);
	end
	ret=fevalalong(@(x,dim)join(x,delimiter(dims==dim),dim),dims,self,Mode="iterate");
end